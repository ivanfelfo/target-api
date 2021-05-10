# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  include DeviseTokenAuth::Concerns::User

  has_many :targets, dependent: :destroy
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :encrypted_password, presence: true
  validates :gender, presence: true
  validates :uid, uniqueness: { scope: :provider }

  before_validation :init_uid

  enum gender: { male: 0, female: 1, other: 2, unknown: 3 }

  private

  def init_uid
    self.uid = email if uid.blank? && provider == 'email'
  end
end
