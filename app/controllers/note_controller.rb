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

    render json: { error: false }
  end

  def update
    p params
    note = current_user.notes.find params[:id]
    params.delete :id

    tags = params[:tags] && params[:tags].split || []
    views = [params[:primary_view], params[:secondary_view]]
    learning_type = params[:learning_type]

    ActiveRecord::Base.transaction do
      note.tags.destroy_all
      note.views.destroy_all
      note.update_attributes!({
        text: permitted_params[:note],
        title: permitted_params[:title],
        note_type: permitted_params[:primary_note_type]
      })

      note.learning_types.destroy_all
      if learning_type
        note.learning_types.create! label: learning_type, user_id: current_user.id
      end

      tags.each do |tag|
        note.tags.create!({user_id: current_user.id, label: tag})
      end

      views.each do |view|
        next if view.nil?
        note.views.create!({user_id: current_user.id, label: view})
      end

      note.note_type = params[:note_type]
      note.save!
    end

    render json: note
  end

  def destroy
    note = current_user.notes.find params[:id]
    render json: { result: note.destroy }
  end

  def show
    note = current_user.notes.find params[:id]
    render partial: 'modal/modal_note', locals: { note: note }
  end

  private

  def permitted_params
    params.permit :title, :note, :primary_view, :secondary_view, :note_type, :learning_type
  end
end
