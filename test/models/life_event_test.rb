# == Schema Information
#
# Table name: life_events
#
#  id          :bigint(8)        not null, primary key
#  user_id     :integer
#  title       :string
#  description :string
#  from_date   :date
#  to_date     :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class LifeEventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
