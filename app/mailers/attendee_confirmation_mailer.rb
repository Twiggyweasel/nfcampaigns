class AttendeeConfirmationMailer < ApplicationMailer
  
  def confirmation_email(user, attendee_record)
    @user = user
    @url = event_attendee_path(attendee_record.event_id, attendee_record.id)
    mail(to: @user.email, subject: '#NFStrong Registration Confirmation')
  end
  
end
