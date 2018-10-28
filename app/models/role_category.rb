# == Schema Information
#
# Table name: role_categories
#
#  label      :string           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  icon_class :string
#

class RoleCategory < ApplicationRecord
  def short_name
    label.capitalize
  end

  def to_s
    I18n.t("role_category.#{label}")
  end
end
