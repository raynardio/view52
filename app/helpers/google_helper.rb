module GoogleHelper
  def google_calendar_list
    gc = GoogleCalendar.new current_user
    gc.calendars
  end
end
