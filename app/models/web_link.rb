# == Schema Information
#
# Table name: web_links
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  item_id     :integer
#  item_type   :string
#  url         :string
#  title       :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class WebLink < ApplicationRecord
  # belongs_to :user
  belongs_to :item, polymorphic: true
  has_many :images, as: :item, dependent: :destroy
  has_many :tags, as: :item, dependent: :destroy
  has_many :views, as: :item, dependent: :destroy

  def self.create_from_url!(url)
    site_info = LinkThumbnailer.generate url
    web_link = WebLink.create!({
      title: site_info.title,
      description: site_info.description,
      url: url
    })

    site_info.images.each do |image|
      web_link.images << Image.create_from_url!(image.src.to_s)
      web_link.save!
    end
  end
end
