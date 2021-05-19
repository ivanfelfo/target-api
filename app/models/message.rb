class Message < ApplicationRecord
  belongs_to :conversation

  validates_presence_of :message, on: :create, message: "can't be blank"
end