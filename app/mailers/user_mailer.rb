class UserMailer < ApplicationMailer
  default from: 'orsusbass@gmail.com'
  
  def welcome_email(user)
    @user = user
    @url = 'http://www.nfstrong.org/login'
    mail(to: @user.email, subject: 'Welcome to #NFStrong Events')
  end
end
