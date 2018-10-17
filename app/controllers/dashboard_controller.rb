class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def page
    render params[:page]
  end
end
