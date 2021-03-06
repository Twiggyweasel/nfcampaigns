class AdminMailer < ApplicationMailer
  default from: 'yglass@nfnetwork.org'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin_mailer.new_users.subject
  #
  def new_users(user, new)
    @user = user
    @new = new
    mail(to: user.email, subject: "NFStrong - New User Summary")
  end

  def new_actions(user, users, attendees, payments)
    @user = user
    @users = users
    @attendees = attendees
    @payments = payments
    mail(to: user.email, subject: "NFStrong - New Actions Summary")
  end

  def new_interest(path)
    @link = path
    mail(to: "yglass@nfnetwork.org", subject: "New Interest Application")
  end
end
