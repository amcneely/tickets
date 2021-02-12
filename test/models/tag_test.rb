require 'test_helper'

class TagTest < ActiveSupport::TestCase

  test "should not save with blank tag name" do
    tag = Tag.new
    assert_not tag.save
  end

  test "should not save with a null count" do
    tag = Tag.new(name: "billing", ticket_count: nil)
    assert_not tag.save
  end

  test "should save with valid values" do
    tag = Tag.new(name: "feature", ticket_count: 7)
    assert tag.save
  end
end
