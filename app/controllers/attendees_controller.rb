class AttendeesController < ApplicationController
  before_action :set_event, only: [:show, :new, :create, :edit, :update]
  before_action :set_attendee, only: [:show, :edit, :update]
  # before_action :set_attendee, except: [:new, :create, :index]
  before_action :require_user, only: [:show, :new, :edit, :destroy]
  # before_action :require_same_user, only: [:show, :destroy, :edit, :update]
  
  
  def index
    @attendees = Attendee.order(:raised).reverse_order 
  end
  
  def show

  end
  
  def new
    @attendee = @event.attendees.new
    5.times { @attendee.guests.build }
  end
  
  def create

    @attendee = @event.attendees.new(attendee_params)
    if @attendee.fee 
      @guest_limit = RegistrationFee.where(event_id: @event.id, amount: @attendee.fee).first.guest_limit
    end
    respond_to do |format|
      if @attendee.save
        @attendee.update_column(:guest_limit,  @guest_limit)
        AttendeeConfirmationMailer.confirmation(current_user, @attendee).deliver_later
        format.html { redirect_to event_attendee_url(@attendee.event, @attendee.id), :flash => { :success => 'Your registration was successfully completed.' }}
      else
        format.html { render :new, :category => @attendee.category }
        format.json { render json: @attendee.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
    @attendee = @event.attendees.find(params[:id])
  end
  
  def update
    @attendee = @event.attendees.find(params[:id])
    
    if @attendee.update(attendee_params)
      redirect_to event_attendee_url(@attendee.event, @attendee), :flash => { :success => "Your registration has been updated."}
    else
      render :edit
    end
  end
  
  def destroy
    @attendee = Attendee.find(params[:id])
    @event = @attendee.event
    @attendee.destroy
    redirect_to event_path(@event), :flash => { :danger => "Registration successfully cancelled" }
  end
  
  def reciept
    @attendee = Attendee.find(params[:attendee_id])
    @payment = @attendee.payments.where(success: true).last
  end
  
  def decline
    @attendee = Attendee.find(params[:attendee_id])
  end
  
  def join_team
    @attendee = Attendee.find(params[:attendee_id])
    @team = Team.find(params[:attendee][:team_id])
    
    @attendee.update_column(:team_id, @team)
    
    respond_to do |format|
      format.js { }
    end
  end
  
  private 
    def set_event
      @event = Event.find_by_title(params[:event_id])
    end
    
    def set_attendee
      @attendee = Attendee.find(params[:id])
    end
    
    def attendee_params
      params.require(:attendee).permit(:fee, :shirt_size, :category, :business_name, :business_logo, :paid, :accepted_terms, :team_id, :event_id, :user_id, guests_attributes: [:id, :fee, :name, :shirt_size, :email])
    end
    
    # def require_same_user
    #   if current_user != @attendee.user
    #     flash[:danger] = "You can only view your own registration"
    #     redirect_to event_path(@event)
    #   end    
    # end
end