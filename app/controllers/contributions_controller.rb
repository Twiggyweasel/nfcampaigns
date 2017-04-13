class ContributionsController < ApplicationController
  # before_action :require_user, only: [:new, :edit, :destroy]
  
  def contribution_select
    @events = Event.all
    

    @pledgepages = PledgePage.all 
  end
  
  def index
    @contributions = Contribution.all
  end
  
  def new 
    @context = context 
    @contribution = @context.contributions.new
  end
  
  def show
    @contribution = Contribution.find(params[:id])
  end
  
  def create 
    @context = context
    @contribution = @context.contributions.new(contribution_params)
    
    if @contribution.save
      redirect_to  new_contribution_payment_path(@contribution)
      # redirect_to context_url(context, @contribution), flash: { success: 'Your Contribution was Successfully created!' }
    else 
      render :new
    end
  end
  
  def edit
    @contribution = Contribution.find(params[:id])
    @context = @contribution.backable
  end
  
  def update
    @contribution = Contribution.find(params[:id])
    if @contribution.update_attributes(contribution_params)
      redirect_to new_contribution_payment_path(@contribution), flash: { success: 'Your Contribution was Successfully Updated!' }
    else
      render :edit
    end
      
  end
  
  def reciept
    @context = context 
    @contribution = Contribution.find(params[:contribution_id])
    @payment = @contribution.payments.where(success: true).first
  end
  
  def decline
    @context = context
    @contribution = Contribution.find(params[:contribution_id])
    @payment = @contribution.payments.where(success: false).last
  end
  
  private
    def contribution_params
      params.require(:contribution).permit(:amount, :honoree, :user_id)
    end
  
    def context
      if params[:event_id]
        id = params[:event_id]
        Event.find_by(params[:event])
      elsif params[:attendee_id]
        id = params[:attendee_id]
        Attendee.find(params[:attendee_id])
      elsif params[:champion_id]
        id = params[:champion_id]
        Champion.find(params[:champion_id])
       else
        id = params[:team_id]
        Team.find(params[:team_id])
      end
    end
  
    def context_url(context, contribution)
      if Event === context
        event_contribution_path(context, contribution)
      elsif Attendee === context
        attendee_pledge_page_path(context, context.pledge_page)
      elseif Champion === context
        champion_contribution_path(context, contribution)
      else
        team_path(context)
      end
    end
    
end