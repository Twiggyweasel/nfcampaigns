class UserMailer < ApplicationMailer
  default from: 'yglass@nfnetwork.org'
  
  def welcome_email(user)
    @user = user
    @url = 'http://www.nfstrong.org/login'
    mail(to: @user.email, subject: 'Welcome to #NFStrong Events')
  end
  
  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "NFStrong - Password Reset"
  end
end
