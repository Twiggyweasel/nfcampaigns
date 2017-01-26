if Rails.env == "development"
  ActiveMerchant::Billing::StripeGateway.wiredump_device = File.open(Rails.root.join("log","active_merchant.log"), "a+")
  ActiveMerchant::Billing::StripeGateway.wiredump_device.sync = true
  ActiveMerchant::Billing::Base.mode = :test

  login = ENV["STRIPE_SECRET_TEST"]
  # login = "436481"
  # password = "wQVx1w0JpnwrFs7yjWc8ff~zfespUN_e"
elsif Rails.env == "production"
  # login = "436481"
  # password = "wQVx1w0JpnwrFs7yjWc8ff~zfespUN_e"
end

GATEWAY = ActiveMerchant::Billing::StripeGateway.new({
  :login => login

})