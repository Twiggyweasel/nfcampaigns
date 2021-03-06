class Admin::PaymentsController < ApplicationController
  layout 'admin'
  before_action :require_user, :require_admin

  def index
    @payments = Payment.all.order(created_at: :desc)
  end

  def show
    @payment = Payment.find(params[:id])
  end
  def new
    @payment = Payment.new
  end

  def create
    @payment = Payment.new(payment_params)

    if @payment.save
      if @payment.process
        redirect_to payments_path, notice: "The user has been successfully charged." and return
      else
        redirect_to payment_path(@payment)
      end
      # render 'new'
    end
  end

  def edit
    @payment = Payment.find(params[:id])
  end

  def update
    @payment = Payment.find(params[:id])

    if @payment.update(payment_params)
      if @payment.success == true
        @payment.payable.update_column(:paid, true)
      else
        @payment.payable.update_column(:paid, false)
      end
      redirect_to admin_payments_path, :flash => { :success => "Payment Successfully Updated" }
    else
      render :new
    end
  end

  def summary
    @payments = Payment.where(success: true)
    @contribtions = Contribution.where(paid: true)
    @attendees = Attendee.where(paid: true)

  end

  private
    def payment_params
      params.require(:payment).permit(:first_name, :last_name, :authorization_code, :confirmation_number, :success, :credit_card_number, :expiration_month, :expiration_year, :card_security_code, :amount)
    end

end
