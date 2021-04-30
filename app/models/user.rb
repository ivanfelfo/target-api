# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :gender, presence: true
  validates :uid, uniqueness: { scope: :provider }

  before_validation :init_uid

  enum gender: { male: 0, female: 1, other: 2, unknown: 3 }

  private

  def self.from_social_provider(provider, user_params)
    where(provider: provider, uid: user_params['id']).first_or_create! do |user|
      user.password = Devise.friendly_token[0, 20]
      user.assign_attributes user_params.except('id')
    end
  end

  def init_uid
    self.uid = email if uid.blank? && provider == 'email'
  end
end
