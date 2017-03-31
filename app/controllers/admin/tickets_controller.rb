class Admin::TicketsController < ApplicationController
  layout 'admin'
  before_action :set_event, only: [:new, :create, :edit, :update, :destroy]
  before_action :require_user, :require_admin
  def new
    @ticket = @event.tickets.new
  end
  
  def create 
    @ticket = @event.tickets.create(ticket_params)
    
    respond_to do |format|
      if @ticket.save
        format.html { redirect_to admin_event_path(@event), :flash => { :success => "Ticket has been sucessfully created" } }
        format.js
      else
        format.html render :new
      end
    end
  end
  
  def edit
    @ticket = Ticket.find(params[:id])
  end
  
  def update
    @ticket = Ticket.find(params[:id])
    
    if @ticket.update(ticket_params)
      redirect_to admin_event_path(@event), :flash => { :success => "Fee Successfully updated"}
    else
      render :edit
    end
  end
  
  def destroy
    
    @ticket = Ticket.find(params[:id])
    @ticket.destroy
    respond_to do |format|
    format.html {  redirect_to admin_event_path(@event), :flash => { :danger => "Fee successfully deleted" } }
    format.js 
    end
  end
  
  private 
  
    def set_event
      @event = Event.find_by_title(params[:event_id])
    end
    
    def ticket_params
      params.require(:ticket).permit(:name, :fee, :date_available, :quantity, :sold, :is_soldout, :event_id)
    end
end