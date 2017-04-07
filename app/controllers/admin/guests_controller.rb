class Admin::GuestsController < ApplicationController
  layout 'admin'
  before_action :set_attendee
  before_action :require_user, :require_admin
  
  
  def edit
    @guest = Guest.find(params[:id])
  end
  
  def update
    @guest = Guest.find(params[:id])
    
    if @guest.update(attendee_params)
      redirect_to admin_event_attendees_path(@attendee.event), :flash => { :success => "Guest successfully updated!"}
    else 
      render :edit
    end
  end
  
  private 
    
    def set_attendee
      @attendee =Attendee.find(params[:attendee_id])
    end
    
    def attendee_params
      params.require(:guest).permit(:name, :email, :fee, :shirt_size, :paid, :attendee_id)
    end
end