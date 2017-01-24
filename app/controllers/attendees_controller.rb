class AttendeesController < ApplicationController
  before_action :set_event, only: [:new, :create, :show ]
  # before_action :require_user, only: [ :new, :create ]
  
  def show
    @attendee = @event.attendees.find(params[:id])
  end
  
  def new
    @attendee = @event.attendees.new
    5.times { @attendee.guests.build }
  end
  
  def create
    @attendee = @event.attendees.new(attendee_params)
    respond_to do |format|
      if @attendee.save
        format.html { redirect_to event_attendee_url(@attendee.event_id, @attendee.id), :flash => { :success => 'Your registration was successfully completed.' }}
      else
        format.html { render :new }
        format.json { render json: @attendee.errors, status: :unprocessable_entity }
      end
    end
    
    
  end
  
  
  private 
    def set_event
      @event = Event.find(params[:event_id])
    end
    
    def attendee_params
      params.required(:attendee).permit(:fee, :shirt_size, :paid, :team_id, :user_id, guests_attributes: [:id, :fee, :name, :shirt_size, :email])
    end

end