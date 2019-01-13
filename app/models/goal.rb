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
#  description      :text
#  goal_date        :date
#
# Indexes
#
#  index_goals_on_user_id  (user_id)
#

class Goal < ApplicationRecord
  TERMS = %w(long short)

  validates :user_id, presence: true

  belongs_to :user
  # belongs_to :role_category
  has_many :views, as: :item, dependent: :destroy
  has_many :tags, as: :item, dependent: :destroy

  def formatted_date
    self.goal_date.strftime '%m/%d/%Y'
  end

  def to_s
    I18n.t("goal_description.#{term}", category: role_category_id.capitalize) + ': ' + text
  end
end
