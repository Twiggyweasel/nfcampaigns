class Admin::UsersController < ApplicationController
  layout "admin"
  before_action :set_user, except: [:index, :new, :create]
  
  def index
    @users = User.where.not(id: current_user.id)
  end
  
  def edit 
    
  end
  
  def update
    
  end
  
  private
    def set_user
      @user = User.find(params[:id])
    end
  
end