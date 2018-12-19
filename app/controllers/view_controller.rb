class ViewController < ApplicationController
  before_action :authenticate_user!

  def create
    view = View.create!({
      user: current_user,
          item_type: params[:item_type],
          item_id: params[:item_id].to_i,
          label: params[:view]
    })

    render json: view
  end

  def destroy
    view = View.where(
        'user_id = ? AND item_type = ? AND label = ?',
        current_user.id, params[:item_type], params[:view]).first

    view.destroy! unless view.nil?

    render json: view
  end
end
