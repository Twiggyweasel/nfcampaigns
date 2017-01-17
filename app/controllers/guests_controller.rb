class GuestsController < ApplicationController
  before_action :set_attendee
  
  def create
    @guest = @attendee.guests.create! guest_params
    
    respond_to do |format|
      if @guest.save
        format.html { redirect_to @guest.attendee, notice: 'Guest was successfully created.' }
        format.js
        format.json { render :show, status: :created, location: @guest }
      else
        format.html { render :new }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private 
    def set_attendee
      @attendee = Attendee.find(params[:attendee_id])    
    end
    
    def guest_params
      params.required(:guest).permit(:name, :email, :fee, :shirt_size)
    end
end