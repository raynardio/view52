# == Schema Information
#
# Table name: user_role_categories
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  role_category_id :string           not null
#  importance       :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_user_role_categories_on_user_id                       (user_id)
#  index_user_role_categories_on_user_id_and_role_category_id  (user_id,role_category_id) UNIQUE
#

class UserRoleCategory < ApplicationRecord
  belongs_to :user
  belongs_to :role_category

  def goals
    Goal.where user_id: user_id, role_category_id: role_category_id
  end

  def short_name
    role_category.short_name
  end

  def icon_class
    role_category.icon_class
  end
end
