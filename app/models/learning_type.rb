# == Schema Information
#
# Table name: learning_types
#
#  id         :bigint(8)        not null, primary key
#  label      :string
#  user_id    :integer
#  item_type  :string
#  item_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LearningType < ApplicationRecord
  TYPES = %w(Audio Visual Textual Experimental)

  belongs_to :user
  belongs_to :item, polymorphic: true
end
