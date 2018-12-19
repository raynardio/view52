# == Schema Information
#
# Table name: web_links
#
#  id          :bigint(8)        not null, primary key
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
  belongs_to :user
  belongs_to :item, polymorphic: true
  has_many :images, as: :item, dependent: :destroy
  has_many :tags, as: :item, dependent: :destroy
  has_many :views, as: :item, dependent: :destroy

  def self.create_from_url!(url, user, item=nil)
    uri = URI url
    url = "https://#{uri.path}" if uri.scheme.nil?
    site_info = LinkThumbnailer.generate url
    web_link = WebLink.create!({
      title: site_info.title,
      description: site_info.description,
      url: url,
      user: user,
      item: item || user
    })

    site_info.images.each do |image|
      web_link.images << Image.create_from_url!(image.src.to_s)
    end

    begin
      web_link.images << Image.create_from_url!(site_info.favicon, 'favicon')
    rescue
      puts "No favicon"
    end


    web_link.save!
    web_link
  end

  def favicon
    images.where(category: 'favicon').first || images.first
  end
end
