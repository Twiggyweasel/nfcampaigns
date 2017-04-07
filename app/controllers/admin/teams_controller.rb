class Admin::TeamsController < ApplicationController
  layout 'admin'
  before_action :set_event
  before_action :require_user, :require_admin
  
  def index 
  end
  
  def new
    @team = Team.new
  end

  def create
    @team = @event.teams.create(team_params)
    
    if @team.save
      redirect_to admin_event_teams_path(@event), :flash => { :success => "Team successfully created" }
    else
      render :new
    end
  end
  
  def edit
    @team = Team.find(params[:id])
  end
  
  def update
    @team = Team.find(params[:id])
    
    if @team.update(team_params)
      redirect_to admin_event_teams_path(@event), :flash => { :success => "Team successfully updated" }
    else
      render :edit
    end
    
  end
  
  def destroy
    
  end
  
  private 
  
  def set_event
    @event = Event.find_by_title(params[:event_id])
  end
  
  def team_params
    params.require(:team).permit(:name, :goal, :max_members)
  end
end