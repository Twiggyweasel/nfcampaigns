class Admin::UsersController < ApplicationController
  layout "admin"
  before_action :set_user, except: [:index, :new, :create]
  before_action :require_user, :require_admin
  
  
  def index
    @users = User.where.not(id: current_user.id)
    respond_to do |format|
      format.html 
      format.xlsx
    end
  end
  
  def edit 
    
  end
  
  def update
    if @user.update(user_params)
      redirect_to admin_users_path, :flash => { :success => "User record successfully updated"}
    else
      render :edit
    end
  end
  
  def destroy
    @user.destroy 
    redirect_to admin_user_path, :flash => { :sucess => "User Successfully Deleted" }
  end
  
  private
    def set_user
      @user = User.find(params[:id])
    end
    
    def user_params
      params.require(:user).permit(:email, :name, :password)
    end
end