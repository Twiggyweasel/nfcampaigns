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
    @promo = Promotion.new
  end

  def create
    @context = context
    @payment = @context.payments.new(payment_params)
    @promo = Promotion.new
    if @payment.save
      if @payment.process
        @payment.finalize
        if @payment.payable_type === "Attendee"
          if @payment.payable.category === "Concert"
            PaymentsMailer.concert_payment.(current_user, @payment).deliver_later
          else
            PaymentsMailer.registration_payment(current_user, @payment).deliver_later
          end  
        end
        
        redirect_to context_url(@context), :flash => { :success => "Your card has been successfully charged." } and return
        # redirect_to event_contribution_reciept_path(@payable.backable, @payable), :flash => { :success => "Your card has been successfully charged." } and return
      else

        redirect_to context_url_decline(context), :flash => { :danger => "Your card was declined please try again." } and return
      end
    end
      render :new 
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
      attendee_decline_path(context)
    end
      
  end
  
  def approved_payment 
    if context.payments.any?
      if context.payments.where(success: true).any?
        redirect_to :back, :flash => { :success => "Payment has already been approved for this item" }
      end
    end
  end
  
  def payment_params
    params.require(:payment).permit(:first_name, :promo_code, :cover_processing, :last_name, :credit_card_number, :expiration_month, :expiration_year, :card_security_code, :amount, :confirmation_number, :street, :apt, :city, :state, :zip)
  end
end
