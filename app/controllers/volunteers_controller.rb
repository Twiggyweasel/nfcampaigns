class VolunteersController < ApplicationController

  def new
    @volunteer = Volunteer.new
  end

  def create
    @volunteer = Volunteer.create(volunteer_params)

    if @volunteer.save
      redirect_to root_path, :flash => { :success => "Request to Volunteer successfully logged" }
    else
      render :new
    end
  end

  private

    def volunteer_params
      params.require(:volunteer).permit(:first_name, :last_name, :street1 , :street2, :city, :state, :zipcode, :email, :shirt_size, :volunteer_type, :group_name, :event_id)
    end
end