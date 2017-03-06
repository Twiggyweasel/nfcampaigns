class RegistrationFeesController < ApplicationController
  before_action :set_event 
  def index
  
  end
  
  def create
    @fee = @event.registration_fees.create! registration_fees_parmas
    
    respond_to do |format|
      if @fee.save
        format.html { redirect_to @fee.event, notice: 'Registration Fee was successfully created.' }
        format.js   { }
        format.json { render :show, status: :created, location: @fee }
      else
        format.html { render :new }
        format.json { render json: @fee.errors, status: :unprocessable_entity }
      end
    end
    
   # redirect_to @event
  end
  
  private 
    def set_event
      @event = Event.find(params[:event_title])    
    end
    
    def registration_fees_parmas
      params.required(:registration_fee).permit(:name, :amount)
    end
end