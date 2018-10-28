class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    # TODO: Create only necessary instance variables
    @role_categories = RoleCategory.all
    @present_roles = current_user.present_roles.map(&:label).join(' ')
    @future_roles = current_user.future_roles.map(&:label).join(' ')
    @today = Date.today
    @annual_dates = []
    (0..9).each do |x|
      @annual_dates << []
      (0..9).each do |y|
        @annual_dates[x] << current_user.date_of_birth + ((x * 10) + y).years
      end
    end
  end
end
