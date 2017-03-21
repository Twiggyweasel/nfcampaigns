class Admin::AttendeesController < ApplicationController
  layout 'admin'
  before_action :set_event 
  before_action :require_user, :require_admin
  
  def index
    @attendees = Attendee.includes(:pledge_page).where(event_id: @event.id)
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
  
  private 
    def set_event 
      @event = Event.find_by_title(params[:event_id])
    end
    
    def attendee_params
      params.require(:attendee).permit(:user_id, :team_id)
    end
end