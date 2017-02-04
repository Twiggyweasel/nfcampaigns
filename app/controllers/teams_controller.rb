class TeamsController < ApplicationController
  before_action :set_event, except: [:index, :new, :create]
  before_action :require_user, only: [:new, :edit, :destroy]
  
  def index
    @teams = Team.order(raised: :desc)
  end
  
  def show
    @team = Team.find(params[:id])
  end
  
  def new
    @team = @event.teams.new
    @attendee = @team.attendees.build
  end
  
  def create
    @team = @event.teams.create(team_params)
    
    if @team.save
      redirect_to event_attendee_path(@team.event_id, @team.attendees.first), flash: { :success => "Team Successfully Created!"}
    else
      render :new
    end
  end
  
  private 
    def set_event
      @event = Event.find(params[:event_id])
    end
    
    def team_params
      params.require(:team).permit(:name, attendees_attributes: [:fee, :shirt_size, :event_id, :user_id])
    end
end