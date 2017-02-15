class PaymentsController < ApplicationController
 before_action :context, only: [:new, :create]
 before_action :approved_payment, only: [:new, :create]
 
  def index
    @payments = Payment.all
  end

  def show
    @payment = Payment.find(params[:id])
  end
  
  def new
    @context = context
    @payment = @context.payments.new
  end

  def create
    @context = context
    @payment = @context.payments.new(payment_params)

    if @payment.save
      if @payment.process
        @payment.finalize

        redirect_to context_url(@context), :flash => { :success => "Your card has been successfully charged." }
        # redirect_to event_contribution_reciept_path(@payable.backable, @payable), :flash => { :success => "Your card has been successfully charged." } and return
      else
        redirect_to context_url_decline(context), :flash => { :danger => "Your card was declined please try again." } 
      end
    else
      render :new
    end
  end

private
  def context
    if params[:contribution_id]
      id = params[:contribution_id]
      Contribution.find(params[:contribution_id])
    elsif params[:attendee_id]
      id = params[:attendee_id]
      Attendee.find(params[:attendee_id])
    end
  end
  
  def context_url(context)
    if Contribution === context
      event_contribution_reciept_path(context.backable, context)
    elsif Attendee === context 
      attendee_reciept_path(context)  
    end
  end
  
  def context_url_decline(context) 
    if Contribution === context
      event_contribution_decline_path(context.backable, context)  
    elsif Attendee === context
    
    end
      
  end
  
  def approved_payment 
    if context.payments.any?
      if context.payments.where(success: true)
        redirect_to :back, :flash => { :success => "Payment has already been approved for this item" }
      end
    end
  end
  
  def payment_params
    params.require(:payment).permit(:first_name, :last_name, :credit_card_number, :expiration_month, :expiration_year, :card_security_code, :amount, :confirmation_number)
  end
end
