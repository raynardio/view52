# == Schema Information
#
# Table name: notes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  text       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string
#
# Indexes
#
#  index_notes_on_title    (title)
#  index_notes_on_user_id  (user_id)
#

class Note < ApplicationRecord
  belongs_to :user
  has_many :tags, as: :item
  has_many :views, as: :item
end
