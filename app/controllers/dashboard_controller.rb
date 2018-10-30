class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    # TODO: Create only necessary instance variables
    if current_user.onboarded?
      @quote = Quote.random.text
      @time_quote = Quote.random('time').text
      @today = Date.today
      @annual_dates = []
      (0..9).each do |x|
        @annual_dates << []
        (0..9).each do |y|
          @annual_dates[x] << current_user.date_of_birth + ((x * 10) + y).years
        end
      end
      @role_categories = current_user.role_categories.order(importance: :desc)

      @time_spent_labels = [
        t(:sleeping),
        t(:commuting),
        t(:exercising),
        t(:working),
        t(:other)
      ]
      other_hours = 24.0 - (
        current_user.sleep_hours +
        current_user.commute_hours +
        current_user.exercise_hours +
        (current_user.weekly_hours / 7.0)
      )
      @time_spent_values = [
          current_user.sleep_hours,
          current_user.commute_hours,
          current_user.exercise_hours,
          (current_user.weekly_hours / 7.0),
          other_hours
      ]

    else
      redirect_to profile_path
    end
  end
end
