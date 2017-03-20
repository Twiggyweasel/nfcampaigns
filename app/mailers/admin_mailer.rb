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
end
