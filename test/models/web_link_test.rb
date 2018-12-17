# == Schema Information
#
# Table name: web_links
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  item_id     :integer
#  item_type   :string
#  url         :string
#  title       :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class WebLinkTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
