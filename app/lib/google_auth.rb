require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/redis_token_store'

class GoogleAuth
  OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
  APPLICATION_NAME = 'View52'
  CREDS_PATH = File.join(Rails.root, 'config', 'google', 'client_id.json')
  DB_NAME = 'google_auth'
  SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY


  def initialize(redirect_uri=nil)
    @client_id = Google::Auth::ClientId.from_file CREDS_PATH
    @token_store = Google::Auth::Stores::RedisTokenStore.new db: DB_NAME
    @redirect_uri = redirect_uri
  end

  def get_auth_url
    @authorizer.get_authorization_url base_url: OOB_URI
  end

  def get_creds(user)
    @token_store.load user.id.to_s
  end

  def authorized?(user)
    get_creds(user).present?
  end

  def web_authorizer
    @authorizer ||= Google::Auth::WebUserAuthorizer.new @client_id, SCOPE, @token_store, @redirect_uri
  end

  def authorizer
    @authorizer ||= Google::Auth::UserAuthorizer.new @client_id, SCOPE, @token_store
  end
end
