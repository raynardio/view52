require 'google/apis/calendar_v3'

class GoogleCalendar
  def initialize(user)
    @auth = GoogleAuth.new
    @user = user
  end

  def calendars
    service.list_calendar_lists
  end

  def events(calendar_id)
    service.list_events calendar_id
  end

  private

  def service
    unless @service.present?
      @service = Google::Apis::CalendarV3::CalendarService.new
      @service.client_options.application_name = GoogleAuth::APPLICATION_NAME
      @service.authorization = @auth.authorizer.get_credentials @user.id.to_s
    end
    @service
  end
end
