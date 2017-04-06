class SponsorshipsController < ApplicationController
  before_action :set_event 
  before_action :require_user
  def new 
    @sponsorship = Sponsorship.new
  end
  
  def create
    @sponsorship = Sponsorship.create(sponsor_params)
    
    if @sponsorship.save
      redirect_to new_sponsorship_payment_path(@event, @sponsorship), :flash => { :success => "Sponsorship Successfully Created!" }
    else
      render :new
    end
  end
  
  def edit 
    @sponsorship = Sponsorship.find(params[:id])
  end
  
  def update 
    @sponsorship = Sponsorship.find(params[:id])
    
    if @sponsor_params.update(sponsor_params)
      redirect_to event_sponsorship_path(@sponsorship), :flash => { :success => "Sponsorship Updated" }
    else
      render :edit
    end
  end
  
  def destoy 
    @sponsorship = Sponsorship.find(params[:id])
    @sponsorship.destroy
    redirect_to event_path(@sponsorship.event), :flash => { :danger => "Sponsorship Cancelled" }
  end
  
  def reciept
    @sponsorship = Sponsorship.find(params[:sponsorship_id])
    @payment = @sponsorship.payments.where(success: true).last
  end
  
  def decline
    @sponsorship = Sponsorship.find(params[:sponsorship_id])
  end
  
  private 
    def set_event
      @event = Event.find_by_title(params[:event_id])
    end
    
    def sponsor_params
      params.require(:sponsorship).permit(:name, :logo, :fee, :quantity, :paid, :event_id, :ticket_id, :sponsor_level_id, :user_id)
    end
end