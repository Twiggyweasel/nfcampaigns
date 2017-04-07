class Admin::OrdersController < ApplicationController
  layout 'admin'
  before_action :set_event
  before_action :require_user, :require_admin
  
  def index 
    @orders = @event.orders.all
  end
  
  def new
    @order = @event.orders.new
    @tickets = @event.tickets.is_available
    @ticket_names = @event.tickets.is_available.map do |item| item.name end 
    @ticket_fees = @event.tickets.is_available.map do |item| item.fee end
    @ticket_ids = @event.tickets.is_available.map do |item| item.id end
    (@event.tickets.is_available.count).times { @order.order_items.build }
  end
  
  def create
    @order = @event.orders.create(order_params)
    @tickets = @event.tickets.is_available
    @ticket_names = @event.tickets.is_available.map do |item| item.name end 
    @ticket_fees = @event.tickets.is_available.map do |item| item.fee end
    @ticket_ids = @event.tickets.is_available.map do |item| item.id end
    
    if @order.save
      redirect_to admin_event_orders_path(@event), :flash => { :success => "Order Successfully Created" }
    else
      render :new
    end
  end
  
  def edit
    @order = Order.find(params[:id])
    @tickets = @event.tickets.is_available
    @ticket_names = @event.tickets.is_available.map do |item| item.name end 
    @ticket_fees = @event.tickets.is_available.map do |item| item.fee end
    @ticket_ids = @event.tickets.is_available.map do |item| item.id end

  end
  
  def update
    @order = Order.find(params[:id])
    @tickets = @event.tickets.is_available
    @ticket_names = @event.tickets.is_available.map do |item| item.name end 
    @ticket_fees = @event.tickets.is_available.map do |item| item.fee end
    @ticket_ids = @event.tickets.is_available.map do |item| item.id end
    
    if @order.update(order_params)
      redirect_to admin_event_orders_path(@event), :flash => { :success => "Order Successfully Created" }
    else
      render :new
    end
  end
  
  
  
  private 
  
    def set_event
      @event = Event.find_by_title(params[:event_id])
    end
    
    def order_params
      params.require(:order).permit(:user_id, :event_id, order_items_attributes: [:id, :quantity, :order_id, :ticket_id])
    end
end