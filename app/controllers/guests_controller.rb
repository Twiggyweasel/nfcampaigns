class GuestsController < ApplicationController
  before_action :set_attendee
  def create
    if @attendee.guests.count == (@attendee.guest_limit)
      redirect_to event_attendee_path(@attendee.event, @attendee), :flash => { :danger => "Guest could not be added. You have reached the guest limit" }
    else
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
  end
  
  def edit
    @guest = @attendee.guests.find(params[:id])
  end
  
  def update
    @guest = @attendee.guests.find(params[:id])
    
    if @guest.update(guest_params)
      redirect_to event_attendee_path(@attendee.event, @attendee), :flash => { :success => "Guest information successfully updated"}
    else
      render :edit
    end
  end
  
  def destroy
    @guest = @attendee.guests.find(params[:id])
    @guest.destroy
    redirect_to event_attendee_path(@attendee.event, @attendee), :flash => { :danger => "Guest has been deleted" }
  end
  
  private 
    def set_attendee
      @attendee = Attendee.find(params[:attendee_id])    
    end
    
    def guest_params
      params.required(:guest).permit(:name, :email, :fee, :shirt_size)
    end
    
end