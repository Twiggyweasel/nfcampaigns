# Preview all emails at http://localhost:3000/rails/mailers/coorinator_interest_mailer
class CoorinatorInterestMailerPreview < ActionMailer::Preview
  def coordinator_interest_email(application)
    @application = application
    mail(to: @application.email, subject: 'NF Events - Coordinator Interest')
  end
end
