class ApplicationsController < ApplicationController
  require 'browser'

  def show
    @application = Application.find(params[:id])
  end

  def new
    @application = Application.new
  end

  def create
    @application = Application.create(application_params)

    if @application.save
      CoordinatorInterestMailer.coordinator_interest_email(@application).deliver_later
      AdminMailer.new_interest(@application).deliver_later
      redirect_to root_path, :flash => { :success => "Your Interest has been logged" }
    else
      render :new
    end
  end

  def edit
    @application = Application.find(params[:id])
  end

  def update
    @application = Application.find(params[:id])

    if @application.update(application_params)
      redirect_to application_path(@application), :flash => { :success => "Your Interest form has been successfully edited"}
    else
      render :edit
    end
  end

  private
    def application_params
      params.require(:application).permit(:name, :email, :phone, :city, :state, :event_type, :comments)
    end

end
