class Conversation < ApplicationRecord
  belongs_to :topic
  has_many :messages, dependent: :destroy

  validates :user_id1, presence: { on: :create }
  validates :user_id2, presence: { on: :create }

  validate :not_same_user

  private

  def not_same_user
    return unless user_id1 == user_id2

    errors.add(:user_id1, I18n.t('conversation.create.restriction'))
  end
end
