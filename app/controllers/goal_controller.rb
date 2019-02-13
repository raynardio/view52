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

  def update
    goal = current_user.goals.find params[:id]
    tags = params[:tags] && params[:tags].split || []
    views = [params[:view]]

    ActiveRecord::Base.transaction do
      goal.tags.destroy_all
      goal.views.destroy_all

      tags.each do |tag|
        goal.tags.create!({user_id: current_user.id, label: tag})
      end

      views.each do |view|
        next if view.nil?
        goal.views.create!({user_id: current_user.id, label: view})
      end

      goal.update_attributes!({
        text: permitted_params[:title],
        term: permitted_params[:term],
        goal_date: (Date.strptime(permitted_params[:goal_date], '%m/%d/%Y') rescue nil),
        description: permitted_params[:description]
      })
      goal.save!
    end

    render json: goal
  end

  def show
    goal = current_user.goals.find params[:id]
    render partial: 'modal/modal_goal', locals: { goal: goal }
  end

  def destroy
    goal = current_user.goals.find params[:id]
    render json: { result: goal.destroy }
  end

  private

  def permitted_params
    params.permit :title, :description, :goal_date, :term
  end
end
