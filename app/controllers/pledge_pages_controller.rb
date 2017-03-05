class PledgePagesController < ApplicationController
  before_action :set_attendee, only: [:show, :new, :create, :edit, :update]
  before_action :no_pledge_page, only: [:show]
  
  def index 
    @pledge_pages = PledgePage.all
  end
  
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
  
  def edit
    @pledge_page = PledgePage.find(params[:id])
  end
  
  def update
    @pledge_page = PledgePage.find(params[:id])
    
    if @pledge_page.update(pledge_page_params)
      redirect_to attendee_pledge_page_path(@attendee, @pledge_page), :flash => { :success => "Your pledge page has been updated!"}
    else
      :edit
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
      params.require(:pledge_page).permit(:goal, :pledge_pic, :has_custom, :has_customized, :nf_connection, :custom_story)
    end
end