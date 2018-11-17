# == Schema Information
#
# Table name: user_roles
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  role_id    :string           not null
#  tense      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_roles_on_role_id_and_user_id  (role_id,user_id) UNIQUE
#

require 'test_helper'

class UserRoleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
