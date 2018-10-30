class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    # TODO: Create only necessary instance variables
    if current_user.onboarded?
      @today = Date.today
      @annual_dates = []
      (0..9).each do |x|
        @annual_dates << []
        (0..9).each do |y|
          @annual_dates[x] << current_user.date_of_birth + ((x * 10) + y).years
        end
      end
      @role_categories = current_user.role_categories.order(importance: :desc)
    else
      redirect_to profile_path
    end
  end
end
