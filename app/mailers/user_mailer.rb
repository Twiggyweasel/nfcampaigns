class UserMailer < ApplicationMailer
  default from: 'orsusbass@gmail.com'
  
  def welcome_email(user)
    @user = user
    @url = 'https://nf-event-manager-twiggyweasel.c9users.io/login'
    mail(to: @user.email, subject: 'Welcome to NFCampaigns')
  end
end
