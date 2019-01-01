class ViewController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to dashboard_path
  end

  def show
    goals_by_view = current_user.views
        .includes(:item)
        .where({ item_type: 'Goal', label: params[:id] })
        .map(&:item)
    @view = {
        label: params[:id].capitalize,
        long_term_goals: current_user.goals.where(term: 'long', role_category_id: params[:id]).all +
            goals_by_view.select { |g| g.term == 'long' },
        short_term_goals: current_user.goals.where(term: 'short', role_category_id: params[:id]).all +
            goals_by_view.select { |g| g.term == 'short' },
        notes: current_user.views
             .includes(:item)
             .where(item_type: 'Note', label: params[:id])
             .map(&:item),
        web_links: current_user.views
             .includes(:item)
             .where(label: params[:id], item_type: 'WebLink')
             .map(&:item),
        life_events: current_user.views
           .includes(:item)
           .where(label: params[:id], item_type: 'LifeEvent')
           .map(&:item)

    }
    @today = Date.today
    @annual_dates = []
    @life_events = {}
    (0..9).each do |x|
      @annual_dates << []
      (0..9).each do |y|
        date = current_user.date_of_birth + ((x * 10) + y).years
        @annual_dates[x] << date
        @life_events[date.year] = @view[:life_events].select { |e| e.date_in_range? date }
      end
    end
  end

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
