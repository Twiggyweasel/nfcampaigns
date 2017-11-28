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

  def over_100
    @attendees = Attendee.where(paid: true).where("raised > ?", 100)
    @donations = Contribution.where(paid: true).where('amount > ?', 100)
    respond_to do |format|
      format.html
      format.xlsx
    end
  end

end