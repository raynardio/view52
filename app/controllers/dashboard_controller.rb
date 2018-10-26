class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @role_categories = RoleCategory.all
    @present_roles = current_user.present_roles.map(&:label).join(' ')
    @future_roles = current_user.future_roles.map(&:label).join(' ')
  end
end
