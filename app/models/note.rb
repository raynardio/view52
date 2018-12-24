# == Schema Information
#
# Table name: notes
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer
#  text       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string
#  note_type  :string
#
# Indexes
#
#  index_notes_on_title    (title)
#  index_notes_on_user_id  (user_id)
#

class Note < ApplicationRecord
  TYPES = %w(Note Resource TODO Journal)

  belongs_to :user
  has_many :tags, as: :item, dependent: :destroy
  has_many :views, as: :item, dependent: :destroy
  has_many :learning_types, as: :item, dependent: :destroy
end
