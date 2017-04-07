class Admin::SponsorLevelsController < ApplicationController
  before_action :set_event, only: [:new, :create, :edit, :update, :destroy]
  before_action :require_user, :require_admin
  
  def new
    @sponsor_level = @event.sponsor_levels.new
  end
  
  def create 
    @sponsor_level = @event.sponsor_levels.create(sponsor_level_params)
    
    respond_to do |format|
      if @sponsor_level.save
        format.html { redirect_to admin_event_path(@event), :flash => { :success => "sponsor_level has been sucessfully created" } }
        format.js
      else
        format.html render :new
        format.js 
      end
    end
  end
  
  def edit
    @sponsor_level = SponsorLevel.find(params[:id])
  end
  
  def update
    @sponsor_level = SponsorLevel.find(params[:id])
    
    if @sponsor_level.update(sponsor_level_params)
      redirect_to admin_event_path(@event), :flash => { :success => "sponsor_level Successfully updated"}
    else
      render :edit
    end
  end
  
  def destroy
    
    @sponsor_level = SponsorLevel.find(params[:id])
    @sponsor_level.destroy
    respond_to do |format|
      format.html {  redirect_to admin_event_path(@event), :flash => { :danger => "sponsor_level successfully deleted" } }
      format.js 
    end
  end
  
  private 
  
    def set_event
      @event = Event.find_by_title(params[:event_id])
    end
    
    def sponsor_level_params
      params.require(:sponsor_level).permit(:name, :desc, :price, :quantity, :event_id, :ticket_id)
    end
end