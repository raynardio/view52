class WebLinkController < ApplicationController
  before_action :authenticate_user!

  def create
    url = URI.parse(URI.encode(params[:url]))
    p "URL #{url}"
    link = WebLink.create_from_url! url, current_user
    redirect_to web_link_path(link)
  end

  def show
    @link = current_user.web_links.find(params[:id])
  end

  def html
    link = current_user.web_links.find(params[:web_link_id])
    render html: open(link.url, &:read).html_safe
  end
end
