require "test_helper"

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

  test "should downcase tag names" do
    tag = Tag.create(name: "SuGGesTION", ticket_count: 12)
    assert_equal tag.name, "suggestion"
  end

  test "should return tag with highest count" do
    assert_equal Tag.most_active.name, "feature_request"
  end

  test "should increment count on tags by name" do
    tag_names = ["feature_request","kudos"]
    Tag.increment_count_for_names(tag_names)
    assert_equal Tag.find_by(name: "feature_request").ticket_count, 102
    assert_equal Tag.find_by(name: "kudos").ticket_count, 1
  end
end
