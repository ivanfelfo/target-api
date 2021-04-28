# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :gender, presence: true

  enum gender: { male: 0, female: 1, other: 2, unknown: 3 }
end
