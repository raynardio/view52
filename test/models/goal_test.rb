# == Schema Information
#
# Table name: goals
#
#  id               :bigint(8)        not null, primary key
#  user_id          :integer
#  role_category_id :string
#  term             :string
#  text             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  description      :text
#  goal_date        :date
#
# Indexes
#
#  index_goals_on_user_id  (user_id)
#

require 'test_helper'

class GoalTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
