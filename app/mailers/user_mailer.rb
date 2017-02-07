class UserMailer < ApplicationMailer
  default from: 'nfcampaigns@nfnetwork.org'
  
  def welcome_email(user)
    @user = user
    @url = 'https://nfcampaigns.herokuapp.com/login'
    mail(to: @user.email, subject: 'Welcome to NFCampaigns')
  end
end
