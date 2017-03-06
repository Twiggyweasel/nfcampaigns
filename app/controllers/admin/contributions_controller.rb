class Admin::ContributionsController < ApplicationController 
  layout 'admin'
  before_action :set_event 
  before_action :require_user, :require_admin
  
  
  def index
    
    # @search = @event.contributions.ransack(params[:q])
    # @contributions = @search.result(distinct: true).includes(:user).page(params[:page])
    
    @contributions = Contribution.where(backable: @event).page params[:page] 
    
    respond_to do |format|
      format.js
      format.html
    end
  end
  

  def create 
    
    @contribution = @event.contributions.create(contribution_params)
    
    respond_to do |format|
      if @contribution.save
        format.js
        
      else
        format.js
      end
    end
  end
  
  
  private 
    def set_event 
      @event = Event.find(params[:event_title])
    end
    
    def contribution_params
      params.require(:contribution).permit(:amount, :honoree, :category, :paid, :user_id)
    end
  
end