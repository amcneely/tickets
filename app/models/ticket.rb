class Ticket < ApplicationRecord
  validates :user_id, numericality: { only_integer: true }
  validates :title, presence: true
end
