class ChampionsController < ApplicationController
  before_action :set_champion, only: [:show, :edit, :update, :destroy]
  # before_action :require_user, only: [:new, :create]
  def index
    @champions = Champion.all
  end

  def show

  end

  def new
    @champion = Champion.new
  end

  def create
    @champion = Champion.create(champion_params)

    if @champion.save
      redirect_to champion_path(@champion), :flash => { :success => "Champion Successfully Created" }
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @champion.update(champion_params)
      redirect_to champion_path(@champion), :flash => { :success => "Champion Successfully Updated" }
    else
      render :edit
    end
  end

  def destroy
    @champion.destroy
    redirect_to user_path(current_user), :flash => { :success => "Champion Successfully Deleted"}
  end

  private

  def set_champion
    @champion = Champion.find(params[:id])
  end

  def champion_params
    params.require(:champion).permit(:submitter, :name, :champion_image, :age, :story, :active, :user_id, :event_id)
  end
end