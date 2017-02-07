class PaymentsController < ApplicationController
 before_action :set_payable, only: [:new, :create]
 
  def index
    @payments = Payment.all
  end

  def show
    @payment = Payment.find(params[:id])
  end
  
  def new
    @payment = @payable.payments.new
  end

  def create
    @payment = @payable.payments.new(payment_params)

    if @payment.save
      if @payment.process
        redirect_to event_contribution_path(@payable.backable, @payable), :flash => { :success => "Your card has been successfully charged." } and return
      else
        redirect_to event_contribution_path(@payable.backable, @payable), :flash => { :danger => "Your card was declined please try again." } 
      end
    else
      render :new
    end
  end

private
  def set_payable
    @payable = Contribution.find(params[:contribution_id])
  end
  
  def payment_params
    params.require(:payment).permit(:first_name, :last_name, :credit_card_number, :expiration_month, :expiration_year, :card_security_code, :amount)
  end
end
