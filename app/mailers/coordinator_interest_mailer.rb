class CoordinatorInterestMailer < ApplicationMailer
  default from: 'orsusbass@gmail.com'
  
  def coordinator_interest_email(application)
    @application = application
    mail(to: @application.email, subject: '#NFStrong - Event Interest')
  end
  
end
