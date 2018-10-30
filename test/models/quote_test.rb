# == Schema Information
#
# Table name: quotes
#
#  id         :integer          not null, primary key
#  quote_type :string
#  text       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class QuoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
