class PledgePagesController < ApplicationController
  before_action :set_attendee, only: [:show, :new, :create]
  before_action :no_pledge_page, only: [:show]
  
  def show
    @pledge_page = @attendee.pledge_page
    # @pledge_page = PledgePage.find(params[:id])
  end
  
  def new
    @pledge_page = @attendee.build_pledge_page
  end
  
  def create
    @pledge_page = @attendee.build_pledge_page(pledge_page_params)
    
    if @pledge_page.save
      redirect_to attendee_pledge_page_path(@attendee, @pledge_page), flash => { :success => "Pledge Page Successfully Created!" }
    else
      render :new
    end
  end
  
  private 
    def no_pledge_page
      if !@attendee.pledge_page
        flash[:danger] = "Pledge Page not Found"
        redirect_to event_path(@attendee.event_id)
      end
    end
    
    def set_attendee
      @attendee = Attendee.find(params[:attendee_id])
    end
  
    def pledge_page_params
      params.require(:pledge_page).permit(:goal)
    end
end