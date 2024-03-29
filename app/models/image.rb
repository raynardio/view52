# == Schema Information
#
# Table name: images
#
#  id           :bigint(8)        not null, primary key
#  item_id      :integer
#  item_type    :string
#  category     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  content_type :string
#  base64       :string
#

class Image < ApplicationRecord
  CATEGORIES = %w(favicon profile other site)

  validates :category, inclusion: CATEGORIES

  def self.create_from_url!(url, category='site')
    res = RestClient.get(url)
    image = Image.create! category: category, content_type: res.headers[:content_type]

    # open(File.join(Rails.root, 'storage', 'images', image.id.to_s), 'w:UTF-8') do |file|
    #   file.write res.body
    # end

    # open(File.join(Rails.root, 'storage', 'images', image.id.to_s), 'w') do |file|
    #   base64 = Base64.encode64 file.read
    # end

    image.base64 = Base64.encode64 res.body

    image.save!
    image
  end

  def path
    File.join Rails.root, 'storage', 'images', id.to_s
  end

  # def base64
  #   open(path, 'rb') do |file|
  #     Base64.encode64 file.read
  #   end
  # end
end
