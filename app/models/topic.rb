class Topic < ApplicationRecord
  has_many :targets, dependent: :destroy
end
