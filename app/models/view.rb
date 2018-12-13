# == Schema Information
#
# Table name: views
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  item_type  :string
#  item_id    :integer
#  label      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class View < ApplicationRecord
  belongs_to :user
  belongs_to :item, polymorphic: true
end
