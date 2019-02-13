# == Schema Information
#
# Table name: life_events
#
#  id                  :bigint(8)        not null, primary key
#  user_id             :integer
#  title               :string
#  description         :string
#  from_date           :date
#  to_date             :date
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  prototype           :boolean          default(FALSE)
#  show_in_annual_view :boolean          default(FALSE)
#

class LifeEvent < ApplicationRecord
  belongs_to :user
  has_many :views, as: :item, dependent: :destroy
  has_many :tags, as: :item, dependent: :destroy
  has_many :web_links, as: :item, dependent: :destroy

  def date_in_range?(date)
    (self.from_date..(self.to_date || Date.today)).include? date
  end
end
