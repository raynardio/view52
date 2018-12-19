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
#
# Indexes
#
#  index_notes_on_title    (title)
#  index_notes_on_user_id  (user_id)
#

require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
