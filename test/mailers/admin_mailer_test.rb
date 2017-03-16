require 'test_helper'

class AdminMailerTest < ActionMailer::TestCase
  test "new_users" do
    mail = AdminMailer.new_users
    assert_equal "New users", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
