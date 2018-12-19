# == Schema Information
#
# Table name: calendar_events
#
#  id          :bigint(8)        not null, primary key
#  user_id     :integer
#  title       :string
#  description :string
#  event_type  :string
#  event_id    :string
#  html_link   :string
#  start_date  :datetime
#  end_date    :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_calendar_events_on_user_id                              (user_id)
#  index_calendar_events_on_user_id_and_event_id_and_event_type  (user_id,event_id,event_type) UNIQUE
#

require 'test_helper'

class CalendarEventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
