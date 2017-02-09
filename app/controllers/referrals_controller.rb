class ReferralsController < ApplicationController
  before_action :set_referral_code, only: [:new]
  def new

    @referral = Referral.new
  end
  
  def create 
    @referral = Referral.create(referral_params)
    
    if @referral.save
      redirect_to root_path, :flash => { :success => "referral created" } 
    else
      render :new
    end
  end
  
  private 
    def set_referral_code
      @referral_code = "NF" + Time.current.year.to_s + 'walk' + (!Referral.last.nil? ? Referral.last.id : 1).to_s
    end
    
    def referral_params
      params.require(:referral).permit(:referral_code, :emails, :user_id)
    end
end