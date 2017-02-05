class PagesController < ApplicationController
  layout "index"
  
  def home
    @top_attendees = Attendee.order(raised: :desc).limit(5)
    @top_teams = Team.where.not(name: 'No Team').order(raised: :desc).limit(5)
    
    @total_raised = Event.all.pluck(:raised).sum
  end
  
  def privacy
    
  end
  
  def attendees
    @attendees = Attendee.all.order(raised: :desc)
  end

end