class CalendarController < ApplicationController
  before_action :authenticate_user!

  def index
    today = Date.today
    year = (params[:year] || today.year).to_i
    month = (params[:month] || today.month).to_i
    day = (params[:day] || today.day).to_i
    view = params[:view] || 'month'

    @calendar = {
        events: [],
        date: Date.new(year, month, day),
        view: view
    }

    current_user.calendar_events.where.not(start_date: nil).find_each do |event|
      @calendar[:events] << {
          title: event.title,
          start: event.start_date.iso8601,
          end: event.end_date.iso8601,
          url: event.html_link
      }
    end
  end
end
