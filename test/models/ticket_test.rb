require "test_helper"

class TicketTest < ActiveSupport::TestCase

  test "should not save without a user_id" do
    ticket = Ticket.new(title: "Feature request")
    assert_not ticket.save
  end

  test "should not save without a title" do
    ticket = Ticket.new(user_id: 22)
    assert_not ticket.save
  end

  test "should save with valid values" do
    ticket = Ticket.new(user_id: 88, title: "Billing issue")
    assert ticket.save
  end
end
