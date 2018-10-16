class DashboardController < ApplicationController
  def index
  end

  def page
    render params[:page]
  end
end
