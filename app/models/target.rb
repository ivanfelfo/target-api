class Target < ApplicationRecord
  belongs_to :topic
  belongs_to :user

  validates :title, presence: true
  validates :radius, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end
