# == Schema Information
#
# Table name: tags
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer
#  item_id    :integer
#  tag_type   :string
#  item_type  :string
#  label      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tags_on_user_id                (user_id)
#  index_tags_on_user_id_and_item_type  (user_id,item_type)
#  index_tags_on_user_id_and_label      (user_id,label)
#  index_tags_on_user_id_and_tag_type   (user_id,tag_type)
#

require 'test_helper'

class TagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
