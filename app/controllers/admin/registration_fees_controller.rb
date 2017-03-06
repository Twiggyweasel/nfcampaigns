class Admin::RegistrationFeesController < ApplicationController
  before_action :set_event, only: [:new, :create, :edit, :update, :destroy]
  before_action :require_user, :require_admin
  def new
    @fee = @event.registration_fees.new
  end
  
  def create 
    @fee = @event.registration_fees.create(fee_params)
    
    respond_to do |format|
      if @fee.save
        # format.html redirect_to admin_event_path(@event), :flash => { :success => "Fee has been sucessfully created" }
        format.js
      else
        format.html render :new
      end
    end
  end
  
  def edit
    @fee = RegistrationFee.find(params[:id])
  end
  
  def update
    @fee = RegistrationFee.find(params[:id])
    
    if @fee.update(fee_params)
      redirect_to admin_event_path(@event), :flash => { :success => "Fee Successfully updated"}
    else
      render :edit
    end
  end
  
  def destroy
    
    @fee = RegistrationFee.find(params[:id])
    @fee.destroy
    respond_to do |format|
    format.html {  redirect_to admin_event_path(@event), :flash => { :danger => "Fee successfully deleted" } }
    format.js 
    end
  end
  
  private 
  
    def set_event
      @event = Event.find_by_title(params[:event_id])
    end
    
    def fee_params
      params.require(:registration_fee).permit(:name, :amount, :category, :description, :event_id, :guest_limit)
    end
end