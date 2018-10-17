# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           not null
#  first_name             :string           not null
#  last_name              :string           not null
#  country                :string
#  city                   :string
#  state                  :string
#  zip                    :string
#  sex                    :string
#  marital_status         :string
#  education              :string
#  diet                   :string
#  commute_hours          :float
#  exercise_hours         :float
#  weekly_hours           :float
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable #, :confirmable

  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :encrypted_password, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
