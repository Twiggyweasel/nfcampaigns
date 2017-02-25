class PromotionsController < ApplicationController
  
  def check_promotion_code
    @attendee = Attendee.find(params[:promotion][:attendee_id])
    if !Promotion.where(:code => params[:promotion][:code]).first.nil? && Promotion.where(:code => params[:promotion][:code]).first.is_active
      @promotion = Promotion.where(:code => params[:promotion][:code]).first
    else 
      @promotion = nil
    end
  
    respond_to do |format|
      if !@promotion.nil?
        format.html { redirect_to :back, :flash => { :success => "#{@promotion.name}" } }
        format.js { render 'check_promotion_code', attendee: @attendee }
      else
  
  
        format.js { render "check_promotion_fail" }
      # redirect_to admin_home_path, :flash => { :danger => "#{params[:code]}" }
        
      end  
    
    end
  end
end