class Admin::AttendeesController < ApplicationController
  layout 'admin'
  before_action :set_event 
  before_action :require_user, :require_admin
  
  def index
    @attendees = Attendee.includes(:pledge_page).where(event_id: @event.id)
    respond_to do |format|
      format.html
      format.xlsx
    end  
    
  end
  
  def show
    @attendee.find(params[:id])
  end
  
  def new
    @attendee = @event.attendees.new
  end
  
  def create
    @attendee = @event.attendees.create(attendee_params)
    
    if @attendee.save
      redirect_to admin_event_attendees_path(@event), :flash => { :success => "Attendee Created!"}
    else 
      render :new
    end
  end
  
  def edit 
    @attendee = Attendee.find(params[:id])
  end
  
  def update
    @attendee = Attendee.find(params[:id])
    
    if @attendee.update(attendee_params)
      redirect_to admin_event_attendees_path(@event), :flash => { :success => "Attendee successfully updated"}
    else
      render :edit
    end
  end
  
  def destroy 
    @attendee = Attendee.find(params[:id]) 
    
    @attendee.destroy
    if @attendee.destroyed?
      redirect_to admin_event_attendees_path(@event), flash => { :danger => "Registration Deleted" }
    else 
      redirect_to admin_event_attendees_path(@event), flash => { :danger => "Registration could not be deleted"}
    end
  end
  
  private 
    def set_event 
      @event = Event.find_by_title(params[:event_id])
    end
    
    def attendee_params
      params.require(:attendee).permit(:user_id, :team_id, :fee, :shirt_size, :category, :paid)
    end
end