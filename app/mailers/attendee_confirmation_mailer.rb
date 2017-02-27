class AttendeeConfirmationMailer < ApplicationMailer
  
  def confirmation(user, attendee_record)
    @user = user
    @attendee = attendee_record
    @url = event_attendee_path(@attendee.event_id, @attendee.id)
    mail(to: @user.email, subject: '#NFStrong Registration Confirmation')
  end
  
end
