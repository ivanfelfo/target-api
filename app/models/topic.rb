class Topic < ApplicationRecord
  has_many :targets, dependent: :destroy
  has_many :conversations

  validates :name, presence: true
end
