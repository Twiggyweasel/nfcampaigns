class CoordinatorInterestMailer < ApplicationMailer
  default from: 'yglass@nfnetwork.org'
  
  def coordinator_interest_email(application)
    @application = application
    mail(to: @application.email, subject: '#NFStrong - Event Interest')
  end
  
end
