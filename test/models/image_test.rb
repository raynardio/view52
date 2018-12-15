# == Schema Information
#
# Table name: images
#
#  id           :integer          not null, primary key
#  item_id      :integer
#  item_type    :string
#  category     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  content_type :string
#

require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
