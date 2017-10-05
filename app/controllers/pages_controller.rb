class PagesController < ApplicationController
  layout "index"

  def home
    @events = Event.order(:event_date).limit(5)
    @top_attendees = Attendee.where(paid: true).order(raised: :desc).limit(5)
    @top_teams = Team.where.not(name: 'No Team').order(raised: :desc).limit(5)

    @total_raised = Event.all.pluck(:raised).sum
  end

  def privacy

  end

  def attendees
    # @attendees = Attendee.all.order(raised: :desc)

    @q = Attendee.all.order(raised: :desc).ransack(params[:q])
    @attendees = @q.result().page params[:page]
  end

  def about

  end

  def privacy

  end


  def nf

  end
end