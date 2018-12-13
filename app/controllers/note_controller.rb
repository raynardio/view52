class NoteController < ApplicationController
  before_action :authenticate_user!

  def create
    p params
    tags = params[:tags] && params[:tags].split || []
    views = params[:views] && params[:views].split || []

    p tags
    p views

    note = current_user.notes.new({
      text: params[:note],
      title: params[:title]
    })
    note.save!

    tags.each do |tag|
      note.tags.create!({
        user_id: current_user.id,
        label: tag
      })
    end

    views.each do |view|
      note.views.create!({
        user_id: current_user.id,
        label: view
      })
    end
    render json: { error: false }
  end

  def show
  end
end
