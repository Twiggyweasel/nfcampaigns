class OrdersController < ApplicationController
  before_action :set_event
  before_action :require_user, only: [:show, :new, :edit, :destroy]
  def new 
    @order = @event.orders.new 
    @tickets = @event.tickets.not_soldout
    @ticket_names = @event.tickets.not_soldout.map do |item| item.name end 
    @ticket_fees = @event.tickets.not_soldout.map do |item| item.fee end
    @ticket_ids = @event.tickets.not_soldout.map do |item| item.id end
    (@event.tickets.count).times { @order.order_items.build }
  end
  
  def create
    @order = @event.orders.create(order_params)
    
    @ticket_names = @event.tickets.map do |item| item.name end 
    @ticket_fees = @event.tickets.map do |item| item.fee end
    @ticket_ids = @event.tickets.map do |item| item.id end
    
    if @order.save
      redirect_to new_order_payment_path(@order)
    else
      render :new
    end
    
  end
  
  def edit 
    @order = Order.find(params[:id])
    @tickets = @event.tickets.not_soldout
    @ticket_names = @event.tickets.not_soldout.map do |item| item.name end 
    @ticket_fees = @event.tickets.not_soldout.map do |item| item.fee end
    @ticket_ids = @event.tickets.not_soldout.map do |item| item.id end
  end
  
  def update
    @order = Order.find(params[:id])
    
    @ticket_names = @event.tickets.map do |item| item.name end 
    @ticket_fees = @event.tickets.map do |item| item.fee end
    @ticket_ids = @event.tickets.map do |item| item.id end
    
    if @order.update(order_params)
      redirect_to new_order_payment_path(@order)
    else
      render :edit
    end
  end
  
  def reciept
    @order = Order.find(params[:order_id])
    @payment = @order.payments.where(success: true).last
  end
  
  def decline
    @order = Order.find(params[:order_id])
  end
  
  private 
  
  def set_event 
    @event = Event.find_by_title(params[:event_id])
  end
  
  def order_params
    params.require(:order).permit(:user_id, :event_id, order_items_attributes: [:id, :quantity, :order_id, :ticket_id])
  end
end