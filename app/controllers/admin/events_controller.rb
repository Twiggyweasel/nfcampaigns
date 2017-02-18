class Admin::EventsController < ApplicationController
  layout "admin"
  before_action :set_event, except: [:index, :new, :create]
  
  def index
    @events = Event.all
  end
  
  def show 
    
  end
  
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.create(event_params)
    if @event.save
      redirect_to admin_event_path(@event), :flash => { :success => "Event was sucessfully created!"}
    else
      render :new
    end
  end
  
  def edit

  end
  
  def update
    if @event.update(event_params)
      redirect_to admin_event_path(@event), :flash => { :success => "Event Successfully Updated!"}
    else
      render :edit
    end
  end
  
  def destroy

    @event.destroy
    redirect_to admin_home_path, :flash => { :danger => "Event Successfully Deleted!"}
  end
  
  
  private
  
    def set_event 
      @event = Event.find(params[:id])
    end
    def event_params
      params.require(:event).permit(:name, :event_cover, :event_card, :desc, :teaser, :registration_date, :event_date, :event_start_time, :goal, :raised, :venue_name, :street, :city, :state, :zipcode, :has_shirts, :is_private, size_ids: [])
    end
end