class Admin::PromotionsController < ApplicationController
  layout "admin"
  before_action :set_promotion, except: [:index, :new, :create]
  before_action :require_user, :require_admin
  
  def index
    @promotions = Promotion.all
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
  
  private
    def set_promotion
      @promotion = Promotion.find(params[:id])
    end
    
    def promotion_params
      params.require(:promotion).permit(:name, :discount, :code, :is_active)
    end
end