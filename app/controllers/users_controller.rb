class UsersController < ApplicationController

  def index
    # @users = User.where.not(id: 1).order(:name).page params[:page]
    @q = User.where.not(id: 1).order(:name).ransack(params[:q])
    @users = @q.result().page params[:page]
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = request.env['omniauth.identity'] ||= User.new
  end

  # def create

  #   @user = User.new(user_params)
  #   if @user.save
  #       #do something
  #       flash[:success] = "Your account has been created successfully!"
  #       session[:user_id] = @user.id
  #       redirect_to events_path
  #   else
  #       render 'new'
  #   end

  # end

  def edit
    @user = User.find(params[:id])
    @profile = @user.profile
  end

  def update
    @user = User.find(params[:id])
    @profile = @user.profile

    if @user.update(user_params)
      redirect_to user_account_settings_path(@user), :flash => { :success => "profile successfully updated"}
    else
      render edit
    end
  end

  private

    def user_params
      params.required(:user).permit(:name, :email, :password, :role_id, :profile_pic, profile_attributes: [:street, :apt, :city, :state, :zipcode] )
    end
end