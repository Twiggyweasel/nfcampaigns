# if Rails.env == "development"
#   ActiveMerchant::Billing::MercuryGateway.wiredump_device = File.open(Rails.root.join("log","active_merchant.log"), "a+")
#   ActiveMerchant::Billing::MercuryGateway.wiredump_device.sync = true
#   ActiveMerchant::Billing::Base.mode = :test


# elsif Rails.env == "production"

# end

# GATEWAY = ActiveMerchant::Billing::MercuryGateway.new({


# })



if Rails.env == "development"
  
  ActiveMerchant::Billing::AuthorizeNetGateway.wiredump_device = File.open(Rails.root.join("log","active_merchant.log"), "a+")
  ActiveMerchant::Billing::AuthorizeNetGateway.wiredump_device.sync = true
  ActiveMerchant::Billing::Base.mode = :test
  
  # ActiveMerchant::Billing::StripeGateway.wiredump_device = File.open(Rails.root.join("log","active_merchant.log"), "a+")
  # ActiveMerchant::Billing::StripeGateway.wiredump_device.sync = true
  # ActiveMerchant::Billing::Base.mode = :test

  # login = ENV["STRIPE_SECRET_TEST"]
  login = ENV["NET_LOGIN"]
  password = ENV["NET_TRAN_KEY"]

elsif Rails.env == "production"
  # login = ENV["STRIPE_SECRET_TEST"]
    ActiveMerchant::Billing::AuthorizeNetGateway.wiredump_device = File.open(Rails.root.join("log","active_merchant.log"), "a+")
  ActiveMerchant::Billing::AuthorizeNetGateway.wiredump_device.sync = true
  login = ENV["NET_LOGIN_LIVE"]
  password = ENV["NET_TRAN_KEY_LIVE"]
end

GATEWAY = ActiveMerchant::Billing::AuthorizeNetGateway.new({
  :login => login,
  :password => password
})