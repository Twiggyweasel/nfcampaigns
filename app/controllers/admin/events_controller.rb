class Admin::EventsController < ApplicationController
  layout "admin"
  before_action :set_event, except: [:index, :new, :create, :concert_summary]
  before_action :require_user, :require_admin


  def index
    @events = Event.all.order(:event_date)
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

  def concert_summary
    @event = Event.find_by_title(params[:event_id])
    @orders = @event.orders.where(paid: true)
    @contributions = @event.contributions.where(paid: true)

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def event_summary
    @event = Event.find_by_title(params[:event_id])
    @attendees = @event.attendees.order(:created_at)
    @contributions = @event.contributions
  end

  def event_team_summary
    @event = Event.find_by_title(params[:event_id])
    @teams = @event.teams.order(:created_at)
    @attendee = @event.attendees
    @contributions = @event.contributions
  end

  def contact_list
    @event = Event.find_by_title(params[:event_id])
    @attendees = @event.attendees.order(:created_at)
  end
  private
    def set_event
      @event = Event.find_by_title(params[:id])
    end
    def event_params
      params.require(:event).permit(:name, :event_cover, :event_card, :event_type, :desc, :teaser, :registration_date, :event_date, :event_start_time, :event_end_time, :goal, :raised, :venue_name, :street, :city, :state, :zipcode, :has_external_registration, :external_url, :has_shirts, :organizer_url, :organizer_logo, :social_image, :social_desc, :is_private, size_ids: [])
    end
end