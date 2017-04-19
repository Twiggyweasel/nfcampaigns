class PaymentsMailer < ApplicationMailer
  default from: 'yglass@nfnetwork.org'

  def registration_payment(user, payment)
    @user = user
    @payment = payment
    mail(to: @user.email, subject: '#NFStrong Registration Payment Receipt')
  end

  def concert_payment(user, payment)
    @user = user
    @payment = payment
    mail(to: @user.email, subject: 'NF Hope Concert Payment Receipt')
  end

  def contribution_payment(payment)
    @payment = payment
    mail(to: @payment.email, subject: "#NF Contribution Recieved - Thank You")
  end
end
