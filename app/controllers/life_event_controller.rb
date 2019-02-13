class LifeEventController < ApplicationController
  before_action :authenticate_user!

  def create
    event = current_user.life_events.create!({
      title: params[:title],
      from_date: (Date.strptime(params[:from_date], '%m/%d/%Y') rescue nil),
      to_date: (Date.strptime(params[:to_date], '%m/%d/%Y') rescue nil),
      description: params[:description]
    })

    unless params[:view].blank?
      event.views.create!({
        user_id: current_user.id,
        label: params[:view]
      })
    end

    unless params[:secondary_view].blank?
      event.views.create!({
        user_id: current_user.id,
        label: params[:secondary_view]
      })
    end

    unless params[:url].blank?
      WebLink.create_from_url! params[:url], current_user, event
    end

    render json: event
  end

  def update
    life_event = current_user.life_events.find params[:id]

    ActiveRecord::Base.transaction do
      life_event.views.destroy_all
      life_event.web_links.destroy_all

      unless params[:view].blank?
        life_event.views.create!({
          user_id: current_user.id,
          label: params[:view]
        })
      end

      unless params[:secondary_view].blank?
        life_event.views.create!({
          user_id: current_user.id,
          label: params[:secondary_view]
        })
      end

      unless params[:url].blank?
        WebLink.create_from_url! params[:url], current_user, life_event
      end

      life_event.update_attributes! permitted_params
      life_event.save!
    end

    render json: { life_event: life_event }
  end

  def show
    life_event = current_user.life_events.find params[:id]
    render partial: 'modal/modal_life_event', locals: { life_event: life_event }
  end

  def destroy
    life_event = current_user.life_events.find params[:id]
    render json: { result: life_event.destroy }
  end

  private

  def permitted_params
    params.permit :title, :from_date, :to_date, :prototype, :show_in_annual_view, :description
  end
end
