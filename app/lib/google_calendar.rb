require 'google/apis/calendar_v3'

class GoogleCalendar
  def initialize(user)
    @auth = GoogleAuth.new
    @user = user
  end

  def list_calendars
    service.list_calendar_lists
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
