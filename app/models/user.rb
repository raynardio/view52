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
#  onboarded_at           :datetime
#  date_of_birth          :date
#  sleep_hours            :float
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  GENDERS = %w(male female prefer_not_to_say)
  MARITAL_STATUSES = %w(single married divorced prefer_not_to_say)
  EDUCATION_LEVELS = %w(middle_school high_school undergraduate graduate)
  WEEKLY_WORK_HOURS = %w(20 30 40)
  NIGHTLY_SLEEP = %w(5 6 7 8)
  COMMUTE_HOURS = %w(.5 1 2 3)
  EXERCISE_HOURS = %w(.25 .5 .75 1)
  DIET = %w(omnivore vegetarian pescitarian vegan)

  has_many :user_roles
  alias_attribute :roles, :user_roles
  has_many :user_role_categories
  alias_attribute :role_categories, :user_role_categories
  has_many :goals

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable #, :confirmable

  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :encrypted_password, presence: true

  def present_roles
    roles.includes(:role).where(tense: :present).map &:role
  end

  def future_roles
    roles.includes(:role).where(tense: :future).map &:role
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def onboarded?
    onboarded_at.present?
  end

  def formatted_dob
    date_of_birth.strftime('%Y-%m-%d') rescue ''
  end
end
