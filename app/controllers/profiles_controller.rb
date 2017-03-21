class ProfilesController < ApplicationController
  before_action :set_user, :require_user
  before_action :single_profile, only: [:new, :create]
  
  def show
    @profile = @user.profile
  end
  
  def new
    @profile = Profile.new
  end
  
  def create 
    @profile = @user.create_profile(profile_params)
    
    if @profile.save
      if session[:return_url] 
        reroute = session[:return_url]
        session.delete(:return_url)
        UserMailer.welcome_email(current_user).deliver_later
        redirect_to reroute, :flash => { :success => "Your Account has been Successfully Created"}
      else
        UserMailer.welcome_email(current_user).deliver_later
        redirect_to root_path, :flash => { :success => "Your Account was Successfully Created" }
      end
    else
      render :new
    end
  end
  
  def has_nf
    @profile = @user.profile 
    
    @profile.update_attributes has_nf: !@profile.has_nf
   
    respond_to do |format|
    
      format.js 
    end
  end
  
  private 
    def set_user
      @user = User.find(params[:user_id])
    end
    
    def profile_params
      params.require(:profile).permit(:street, :apt, :city, :state, :zipcode, :phone, :referral_code, :has_nf, :child_with_nf, :news_letter, :event_notifications, :is_private, :user_id)
    end
end