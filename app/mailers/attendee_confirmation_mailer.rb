class AttendeeConfirmationMailer < ApplicationMailer
  default from: 'yglass@nfnetwork.org'
  
  def confirmation(user, attendee_record)
    @user = user
    @attendee = attendee_record
    mail(to: @user.email, subject: '#NFStrong Registration Confirmation')
  end
  
end
