class Admin::PromoCardsController < ApplicationController
  layout "admin"
  before_action :set_event
  
  
  def new
    @promocard = @event.build_promo_card
  end
  
  def create
    @promocard = @event.build_promo_card(promo_card_params)
    
    if @promocard.save
      redirect_to admin_event_path(@event), :flash => { :success => "PromoCard successfully created!" }
    else 
      render :new
    end
  end

  def edit
    @promocard = PromoCard.find(params[:id])
  end
  
  def update
    @promocard = PromoCard.find(params[:id])
    
    if @promocard.update(promo_card_params)
      redirect_to admin_event_path(@event), :flash => { :success => "PromoCard successfully updated!"}
    else 
      render :edit
    end
  end
  private 
  
    def set_event 
      @event = Event.find_by_title(params[:event_id])
    end
    
    def promo_card_params
      params.require(:promo_card).permit(:image, :align_image, :remote_image_url, :remote_background_image_url, :promotion_id, :event_id)
    end
  
end