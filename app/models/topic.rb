class Topic < ApplicationRecord
  has_many :targets, dependent: :destroy
  has_many :conversations, dependent: :destroy

  validates :name, presence: true
end
