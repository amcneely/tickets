class Tag < ApplicationRecord
  validates :name, presence: true
  validates :ticket_count, numericality: { only_integer: true,
            greater_than_or_equal_to: 0 }
end
