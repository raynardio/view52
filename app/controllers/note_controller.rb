class NoteController < ApplicationController
  before_action :authenticate_user!

  def index
    @notes = current_user.notes
  end

  def create
    p params
    tags = params[:tags] && params[:tags].split || []

    p tags

    note = current_user.notes.new({
      text: params[:note],
      title: params[:title],
      note_type: params[:primary_note_type]
    })
    note.save!

    tags.each do |tag|
      note.tags.create!({
        user_id: current_user.id,
        label: tag
      })
    end

    unless params[:primary_view].empty?
      note.views.create!({
          user_id: current_user.id,
          label: params[:primary_view]
      })
    end

    unless params[:secondary_view].empty?
      note.views.create!({
        user_id: current_user.id,
        label: params[:secondary_view]
      })
    end

    note.learning_types.create!({
        user_id: current_user.id,
        label: params[:learning_type]
    })

    # views.each do |view|
    #   note.views.create!({
    #     user_id: current_user.id,
    #     label: view
    #   })
    # end
    render json: { error: false }
  end

  def update
    note = current_user.notes.find params[:id]
    params.delete :id

    tags = params[:tags] && params[:tags].split || []
    views = params[:views] && params[:views].split || []

    ActiveRecord::Base.transaction do
      note.tags.destroy_all
      note.views.destroy_all
      note.update_attributes!({
        text: permitted_params[:note],
        title: permitted_params[:title],
        note_type: permitted_params[:primary_note_type]
      })
      tags.each do |tag|
        note.tags.create!({user_id: current_user.id, label: tag})
      end

      views.each do |view|
        note.views.create!({user_id: current_user.id, label: view})
      end
    end

    render json: note
  end

  def show
    @note = current_user.notes.find params[:id]
  end

  private

  def permitted_params
    params.permit :title, :note, :primary_view, :secondary_view, :note_type, :learning_type
  end
end
