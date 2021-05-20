class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  scope :unread, -> { where(read: false) }

  validates :message, presence: { on: :create, message: "can't be blank" }
end
