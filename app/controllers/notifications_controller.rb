class NotificationsController < ApplicationController
  before_action :set_user
  def index
    @attendees = @user.attendees.where(paid: false)
    @orders = @user.orders.where(paid: false)
    @contributions = @user.contributions.where(paid: false)
  end
  
  private 
  
  def set_user
    @user = current_user
  end
end