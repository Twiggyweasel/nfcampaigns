class Admin::RegistrationFeesController < ApplicationController
  before_action :set_event, only: [:new, :create, :edit, :update]
  before_action :require_user, :require_admin
  def new
    @fee = @event.registration_fees.new
  end
  
  def create 
    @fee = @event.registration_fees.create(fee_params)
    
    if @fee.save
      redirect_to admin_event_path(@event), :flash => { :success => "Fee has been sucessfully created" }
    else
      
    end
  end
  
  private 
  
    def set_event
      @event = Event.find(params[:event_id])
    end
    
    def fee_params
      params.require(:registration_fee).permit(:name, :amount, :event_id)
    end
end