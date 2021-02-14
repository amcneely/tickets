require 'test_helper'

class TicketsControllerTest < ActionDispatch::IntegrationTest
  test "should return 422 when missing parameters" do
    post tickets_path, params: {}, as: :json
    assert_response(422)
  end

  test "should create ticket on valid parameters with no tags" do
    assert_difference 'Ticket.count', 1 do
      post tickets_path, params: { user_id: 11, title: "Suggestion" }, as: :json
      assert_response :success
    end
  end

  test "should increment tag counts when valid" do
    assert_difference 'Ticket.count', 1 do
      post tickets_path, params: { user_id: 44, title: "Two Things",
           tags: ["billing_issue","kudos"] }, as: :json
      assert_response :success
      assert_equal Tag.find_by(name: "billing_issue").ticket_count, 4
      assert_equal Tag.find_by(name: "kudos").ticket_count, 1
    end
  end

  test "should return 422 if 5 or more tags" do
    assert_no_difference 'Ticket.count' do
      post tickets_path, params: { user_id: 99, title: "So Many Things",
           tags: ["billing_issue","kudos","this","that","the_other"] }, as: :json
      assert_response(422)
      assert_equal Tag.find_by(name: "billing_issue").ticket_count, 3
    end
  end

  test "should return 422 if incorrect tag format" do
    assert_no_difference 'Ticket.count' do
      post tickets_path, params: { user_id: 50, title: "Hey There",
           tags: "should_be_array" }, as: :json
      assert_response(422)
    end
  end

  test "should return 422 if not strings for tags" do
    assert_no_difference 'Ticket.count' do
      post tickets_path, params: { user_id: 40, title: "I Like Numbers",
           tags: [41,42,43] }, as: :json
      assert_response(422)
    end
  end

  test "should be case-insensitive on tag names" do
    assert_no_difference 'Tag.count' do
      post tickets_path, params: { user_id: 30, title: "SO MAD",
           tags: ["BILLING_ISSUE"] }, as: :json
      assert_equal Tag.find_by(name: "billing_issue").ticket_count, 4
    end
  end

  test "should send webhook request with most active tag" do
    uri = URI(LATEST_WEBHOOK_REQUEST_URL)
    old_latest_result = Net::HTTP.get(uri)
    post tickets_path, params: { user_id: 52, title: "Callbacks" }, as: :json
    assert_response :success
    new_latest_result = Net::HTTP.get(uri)
    assert_not_equal old_latest_result, new_latest_result
    assert new_latest_result["feature_request"]
  end
end
