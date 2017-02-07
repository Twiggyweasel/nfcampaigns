class UserMailer < ApplicationMailer
  default from: 'orsusbass@gmail.com'
  
  def welcome_email(user)
    @user = user
    @url = 'https://nfcampaigns.herokuapp.com/login'
    mail(to: @user.email, subject: 'Welcome to NFCampaigns')
  end
end
