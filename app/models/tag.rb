class Tag < ApplicationRecord
  validates :name, presence: true
  validates :ticket_count, numericality: { only_integer: true,
            greater_than_or_equal_to: 0 }

  def self.most_active
    self.order("ticket_count DESC").first
  end

  def self.increment_count_for_names(tag_names)
    tag_names.each do |tag_name|
      tag = self.find_or_create_by(name: tag_name)
      tag.update!(ticket_count: tag.ticket_count + 1)
    end
  end
end
