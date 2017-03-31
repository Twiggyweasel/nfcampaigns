class Admin::OrdersController < ApplicationController
  layout 'admin'
  before_action :set_event
  before_action :require_user, :require_admin
  def index 
    @orders = @event.orders.all
  end
  
  private 
  
  def set_event
    @event = Event.find_by_title(params[:event_id])
  end
end