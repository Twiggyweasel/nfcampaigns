class Admin::ReportsController < ApplicationController

  def index

  end

  def unpaid_registrations

    @attendees = Attendee.where(paid: false).order(:created_at)
    respond_to do |format|
      format.html
      format.xlsx
    end

  end


end