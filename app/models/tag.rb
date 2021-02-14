class Tag < ApplicationRecord
  validates :name, presence: true
  validates :ticket_count, numericality: { only_integer: true,
            greater_than_or_equal_to: 0 }
  before_save { name.downcase! }

  def self.most_active
    self.order("ticket_count DESC").first
  end

  def self.valid_tag_names?(tag_names)
    return true if tag_names.nil?
    return false unless tag_names.class == Array
    return false unless tag_names.select {|x| x.class != String}.empty?
    return false if tag_names.count >= 5
    true
  end

  def self.increment_count_for_names(tag_names)
    return nil if tag_names.nil?
    tag_names.each do |tag_name|
      tag = self.find_or_create_by(name: tag_name.downcase)
      tag.update!(ticket_count: tag.ticket_count + 1)
    end
  end

  def self.send_most_active
    uri = URI(ACTIVE_TAG_WEBHOOK_REQUEST_URL)
    res = Net::HTTP.post_form(uri, "most_active_tag" => most_active.name,
                                   "ticket_count" => most_active.ticket_count)
  end
end
