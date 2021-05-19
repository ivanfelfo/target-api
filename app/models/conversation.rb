class Conversation < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  has_many :messages

  validates_presence_of :user_id1, on: :create, message: "can't be blank"
  validates_presence_of :user_id2, on: :create, message: "can't be blank"
  validates_presence_of :topic_id, on: :create, message: "can't be blank"
end