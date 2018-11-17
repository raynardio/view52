module GoogleHelper
  def google_calendar_list
    gc = GoogleCalendar.new current_user
    gc.list_calendars
  end
end
