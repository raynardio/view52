# == Schema Information
#
# Table name: user_roles
#
#  id         :bigint(8)        not null, primary key
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

class UserRole < ApplicationRecord
  belongs_to :user
  belongs_to :role
end
