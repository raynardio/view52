class GoalController < ApplicationController
  before_action :authenticate_user!

  def create
    tags = params[:tags] && params[:tags].split || []

    goal = current_user.goals.create!({
      text: params[:text],
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
    goal = current_user.goals.includes(:tags).find params[:id]

    parms = permitted_params

    unless parms[:tags].blank?
      goal.tags.destroy_all
      parms[:tags].split.each do |tag|
        goal.tags.create!({
          user_id: current_user.id,
          label: tag
        })
      end
      parms.delete :tags
    end

    unless parms[:view].blank?
      goal.views.destroy_all
      goal.views.create!({
        user_id: current_user.id,
        label: parms[:view]
      })
      parms.delete :view
    end

    goal.update_attributes parms

    render json: goal
  end

  def show
    goal = current_user.goals.includes(:tags).find params[:id]
    respond_to do |format|
      format.json { render json: goal.attributes.merge({
          tags: goal.tags.map(&:label),
          goal_date: goal.formatted_date,
          view: (goal.views.first.label rescue '')
      })}
    end
  end

  private

  def permitted_params
    params.permit(:text, :term, :goal_date, :tags, :view, :description)
  end
end
