class Target < ApplicationRecord
  MAX_TARGETS_PER_USER = 3

  belongs_to :topic
  belongs_to :user

  validates :title, presence: true
  validates :radius, presence: true, numericality: { greater_than: 0 }
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true
end
