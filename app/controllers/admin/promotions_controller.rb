class Admin::PromotionsController < ApplicationController
  layout "admin"
  before_action :set_promotion, except: [:index, :new, :create]
  before_action :require_user, :require_admin
  
  def index
    @promotions = Promotion.all
  end
  
  def create
    @promotion = Promotion.create(promotion_params)
    
    
    respond_to do |format|
      if @promotion.save
        format.js
        
      else
        format.js
      end
    end
  end
  
  
  def edit 
    #promotion var set by before_action
  end
  
  def update 
    if @promotion.update(promotion_params)
      redirect_to admin_promotions_path, :flash => { :success => "Promotion Successfully Updated!" }
    else
      render :edit
    end
  end
  
  def destroy
    
    @promotion.destroy
    
    respond_to do |format|
      format.js
    end
  end
  
  private
    def set_promotion
      @event = Event.find_by_title(params[:event_id])
    end
    
    def promotion_params
      params.require(:promotion).permit(:name, :discount, :code, :start, :stop, :is_active)
    end
end