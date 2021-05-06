class Target < ApplicationRecord
  MAX_TARGETS_PER_USER = 10

  belongs_to :topic
  belongs_to :user

  validates :title, presence: true
  validates :radius, presence: true, numericality: { greater_than: 0 }
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true

  validate :user_target_limit

  private

  def user_target_limit
    return unless user.present? && user.targets.count >= Target::MAX_TARGETS_PER_USER

    errors.add(:user, I18n.t('targets.create.limit_reached', limit: MAX_TARGETS_PER_USER))
  end
end
