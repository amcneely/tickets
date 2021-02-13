require 'test_helper'

class TicketsControllerTest < ActionDispatch::IntegrationTest
  test "should return 422 when missing parameters" do
    post tickets_path, params: {}, as: :json
    assert_response(422)
  end

  test "should create ticket on valid parameters" do
    assert_difference 'Ticket.count', 1 do
      post tickets_path, params: { user_id: 11, title: "Suggestion" }, as: :json
      assert_response :success
    end
  end
end
