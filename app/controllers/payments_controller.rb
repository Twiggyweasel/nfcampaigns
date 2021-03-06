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
          PaymentsMailer.registration_payment(current_user, @payment).deliver_later
        elsif @payment.payable.category === "Concert"
          PaymentsMailer.concert_payment.(current_user, @payment).deliver_later
        else
          PaymentsMailer.contribution_payment(@payment).deliver_later
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
    elsif params[:sponsorship_id]
      id = params[:sponorship_id]
      Sponsorship.find(params[:sponsorship_id])
    else
      id = params[:order_id]
      Order.find(params[:order_id])
    end
  end

  def context_url(context)
    if Contribution === context
      event_contribution_reciept_path(context.backable, context)
    elsif Attendee === context
      attendee_reciept_path(context)
    elsif Sponsorship === context
      sponsorship_reciept_path(context)
    else
      order_reciept_path(context)
    end
  end

  def context_url_decline(context)
    if Contribution === context
      event_contribution_decline_path(context.backable, context)
    elsif Attendee === context
      attendee_decline_path(context)
    elsif Sponsorship === context
      sponsorship_decline_path(context)
    else
      order_decline_path(context)
    end

  end

  def approved_payment
    if context.is_a? Attendee
      if context.paid && context.guests.where(paid: false).blank?
        redirect_to :back, :flash => { :success => "Payment has already been approved for this item" }
      end
    elsif context.paid
      redirect_to :back, :flash => { :success => "Payment has already been approved for this item" }
    end
  end

  def payment_params
    params.require(:payment).permit(:first_name, :promo_code, :cover_processing, :last_name, :credit_card_number, :expiration_month, :expiration_year, :card_security_code, :amount, :confirmation_number, :street, :apt, :city, :state, :zip, :email, :fee)
  end
end
