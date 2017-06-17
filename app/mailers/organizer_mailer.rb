class OrganizerMailer < ApplicationMailer
  default from: 'yglass@nfnetwork.org'

  def new_attendee(organizer, attendee)
    @organizer = organizer
    @attendee = attendee
    mail(to: organizer.email, subject: "NFStrong - New Attendee")
  end

end
