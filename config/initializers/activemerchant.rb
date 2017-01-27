# if Rails.env == "development"
#   ActiveMerchant::Billing::MercuryGateway.wiredump_device = File.open(Rails.root.join("log","active_merchant.log"), "a+")
#   ActiveMerchant::Billing::MercuryGateway.wiredump_device.sync = true
#   ActiveMerchant::Billing::Base.mode = :test


# elsif Rails.env == "production"

# end

# GATEWAY = ActiveMerchant::Billing::MercuryGateway.new({


# })



if Rails.env == "development"
  ActiveMerchant::Billing::StripeGateway.wiredump_device = File.open(Rails.root.join("log","active_merchant.log"), "a+")
  ActiveMerchant::Billing::StripeGateway.wiredump_device.sync = true
  ActiveMerchant::Billing::Base.mode = :test

  login = ENV["STRIPE_SECRET_TEST"]

elsif Rails.env == "production"
  login = ENV["STRIPE_SECRET_TEST"]

end

GATEWAY = ActiveMerchant::Billing::StripeGateway.new({
  :login => login

})