class TagController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: current_user.tags.map(&:label)
  end

  def create
    attrs = {
        user_id: current_user.id,
        label: params[:tag],
        item_type: params[:item_type] || 'User',
        item_id: params[:item_id] || current_user.id
    }
    tag = Tag.create!(attrs).attributes
    render json: { tag: tag }
  end
end
