# == Schema Information
#
# Table name: life_events
#
#  id          :bigint(8)        not null, primary key
#  user_id     :integer
#  title       :string
#  description :string
#  from_date   :date
#  to_date     :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class LifeEvent < ApplicationRecord
  belongs_to :user
  has_many :views, as: :item, dependent: :destroy
  has_many :tags, as: :item, dependent: :destroy
  has_many :web_links, as: :item, dependent: :destroy
end