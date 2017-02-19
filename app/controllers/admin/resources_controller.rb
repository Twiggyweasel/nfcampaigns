class Admin::ResourcesController < ApplicationController
  before_action :set_event, only: [:new, :create, :edit, :update]
  layout 'admin'
  
  def new
    @resource = @event.resources.new
  end
  
  def create 
    @resource = @event.resources.create(resource_params)
    
    if @resource.save 
      redirect_to admin_event_path(@event), :flash => { :success => "Resource Successfully created" }
    else
      render :new
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
  
  private 
    def set_event
      @event = Event.find(params[:event_id])
    end
  
    def resource_params
      params.require(:resource).permit(:name, :attachment, :event_id)
    end
end