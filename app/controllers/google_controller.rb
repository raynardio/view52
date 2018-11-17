require 'googleauth/web_user_authorizer'

class GoogleController < ApplicationController
  before_action :authenticate_user!
  before_action :google_auth!, except: %i(oauth2callback)

  def oauth2callback
    redirect_to Google::Auth::WebUserAuthorizer.handle_auth_callback_deferred request
  end

  def calendar
  end

  private

  def google_auth!
    auth = GoogleAuth.new google_oauth2callback_url
    user_id = current_user.id.to_s
    creds = auth.web_authorizer.get_credentials user_id, request
    if creds.nil?
      redirect_to auth.web_authorizer.get_authorization_url(
          user_id: user_id,
          request: request
      )
    end
  end
end
