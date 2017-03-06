class Admin::ResourcesController < ApplicationController
  layout 'admin'
  before_action :set_event, only: [:new, :create, :edit, :update, :destroy]
  before_action :require_user, :require_admin
  
  def new
    @resource = @event.resources.new
  end
  
  def create 
    @resource = @event.resources.create(resource_params)
    
    respond_to do |format|
      if @resource.save 
        format.html { redirect_to admin_event_path(@event), :flash => { :success => "Resource Successfully created" } }
        format.js
      else
        format.html render :new
      end
    end
  end

  def edit 
    @resource = Resource.find(params[:id])
  end
  
  def update
    @resource = Resource.find(params[:id])
    
    if @resource.update(resource_params)
      redirect_to admin_event_path(@event), :flash => { :warning => 'Resource Successfully Updated'}
    else
      render :edit
    end
  end
  
  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy
    
    respond_to do |format|
      format.html { redirect_to admin_event_path(@event), :flash => { :danger => "Resource successfully removed"} }
      format.js
    end 
  end
  
  private 
    def set_event
      @event = Event.find_by_title(params[:event_id])
    end
  
    def resource_params
      params.require(:resource).permit(:name, :attachment, :event_id)
    end
end