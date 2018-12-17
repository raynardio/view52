# -*- coding: utf-8 -*-

class WebLinkController < ApplicationController
  before_action :authenticate_user!

  def create
    url = URI.parse(URI.encode(params[:url]))
    p "URL #{url}"
    link = WebLink.create_from_url! url, current_user
    redirect_to link
  end

  def show
    @link = current_user.web_links.find(params[:id])
  end
end
