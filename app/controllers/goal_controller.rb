class GoalController < ApplicationController
  before_action :authenticate_user!

  def create
    tags = params[:tags] && params[:tags].split || []

    goal = current_user.goals.create!({
      text: params[:title],
      term: params[:term],
      goal_date: (Date.strptime(params[:goal_date], '%m/%d/%Y') rescue nil),
      description: params[:description]
    })

    unless params[:view].empty?
      goal.views.create!({
        user_id: current_user.id,
        label: params[:view]
      })
    end

    tags.each do |tag|
      goal.tags.create!({
        user_id: current_user.id,
        label: tag
      })
    end

    render json: goal
  end
end
