# == Schema Information
#
# Table name: goals
#
#  id               :bigint(8)        not null, primary key
#  user_id          :integer
#  role_category_id :string
#  term             :string
#  text             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_goals_on_user_id  (user_id)
#

class Goal < ApplicationRecord
  TERMS = %w(long short)

  validates :user_id, presence: true
  validates :role_category_id, presence: true
  validates :text, presence: true

  belongs_to  :user
  belongs_to :role_category

  def to_s
    I18n.t("goal_description.#{term}", category: role_category_id.capitalize) + ': ' + text
  end
end
