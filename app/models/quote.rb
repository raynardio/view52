# == Schema Information
#
# Table name: quotes
#
#  id         :bigint(8)        not null, primary key
#  quote_type :string
#  text       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Quote < ApplicationRecord
  def self.random(type=nil)
    Quote.find(Quote.where(quote_type: type).pluck(:id).sample)
  end
end
