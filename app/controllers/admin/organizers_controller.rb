class Admin::OrganizersController < ApplicationController
  layout 'admin'
  before_action :set_event, only: [:index, :edit, :update, :destroy, :create]

  def index
    @organizers = @event.organizers.order(:name)
  end

  def create
    @organizer = @event.organizers.create(organizers_params)
    respond_to do |format|
      if @organizer.save
        format.html { redirect_to admin_event_organizers_path(@event), :flash => { :success => "Resource Successfully created" } }
        format.js
      else
        format.html render :new
        format.js
      end
    end
  end

  def edit
    @organizer = Organizer.find(params[:id])
  end

  def update
    @organizer = Organizer.find(params[:id])

    if @organizer.update(organizers_params)
      redirect_to admin_event_organizers_path(@event), :flash => { :success => 'Organizers Information Updated!'}
    else
      render edit
    end

  end

  def destroy
    @organizer = Organizer.find(params[:id])
    @organizer.destroy

    respond_to do |format|
      format.html { redirect_to admin_event_path(@event), :flash => { :danger => "Resource successfully removed"} }
      format.js
    end
  end

  private
    def set_event
      @event = Event.find_by_title(params[:event_id])
    end

    def organizers_params
      params.require(:organizer).permit(:name, :email, :event_id)
    end
end