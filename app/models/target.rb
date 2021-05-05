class Target < ApplicationRecord
  MAX_TARGETS_PER_USER = 3

  belongs_to :topic
  belongs_to :user

  validates :title, presence: true
  validates :radius, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end