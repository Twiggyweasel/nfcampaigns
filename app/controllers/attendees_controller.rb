class AttendeesController < ApplicationController
  before_action :set_event, only: [:show, :new, :create, :edit, :update]
  before_action :require_user, only: [:new, :edit, :destroy]
  
  def index
    @attendees = Attendee.order(:raised).reverse_order 
  end
  
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
  
  def edit
    @attendee = @event.attendees.find(params[:id])
  end
  
  def update
    @attendee = @event.attendees.find(params[:id])
    
    if @attendee.save(attendee_params)
      redirect_to event_attendee_url(@attendee.event, @attendee), :flash => { :success => "Your registration has been updated."}
    else
      render :edit
    end
  end
  
  def destroy
    
    @attendee = Attendee.find(params[:id])
    @event = @attendee.event
    @attendee.destroy
    redirect_to event_path(@event), :flash => { :danger => "Registration successfully cancelled" }
  end
  
  private 
    def set_event
      @event = Event.find(params[:event_id])
    end
    
    def attendee_params
      params.required(:attendee).permit(:fee, :shirt_size, :paid, :team_id, :user_id, guests_attributes: [:id, :fee, :name, :shirt_size, :email])
    end

end