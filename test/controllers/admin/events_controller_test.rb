require 'test_helper'

class Admin::EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:one)
  end
  
  test "should get index" do
    get events_url
    assert_response :success
  end
  
  test "should get show" do 
    get event_url(@event)
    assert_response :success
  end
end