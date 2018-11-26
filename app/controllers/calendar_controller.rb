class CalendarController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = []
    current_user.calendar_events.where.not(start_date: nil).find_each do |event|
      @events << {
          title: event.title,
          start: event.start_date.iso8601,
          end: event.end_date.iso8601,
          url: event.html_link
      }
    end
  end
end
