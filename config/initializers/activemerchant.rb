# if Rails.env == "development"
  
#   ActiveMerchant::Billing::AuthorizeNetGateway.wiredump_device = File.open(Rails.root.join("log","active_merchant.log"), "a+")
#   ActiveMerchant::Billing::AuthorizeNetGateway.wiredump_device.sync = true
#   ActiveMerchant::Billing::Base.mode = :test
  
#   login = ENV["NET_LOGIN"]
#   password = ENV["NET_TRAN_KEY"]
#   testing = true
# elsif Rails.env == "production"
  
#   ActiveMerchant::Billing::AuthorizeNetGateway.wiredump_device = File.open(Rails.root.join("log","active_merchant.log"), "a+")
#   ActiveMerchant::Billing::AuthorizeNetGateway.wiredump_device.sync = true
#   ActiveMerchant::Billing::Base.mode = :production
  
#   login = ENV["NET_LOGIN_LIVE"]
#   password = ENV["NET_TRAN_KEY_LIVE"]
# end

# GATEWAY = ActiveMerchant::Billing::AuthorizeNetGateway.new({
#   :login => login,
#   :password => password,
# })