class PagesController < ApplicationController
  layout "index"
  
  def home
    @events = Event.order(:event_date).limit(5)
    @top_attendees = Attendee.order(raised: :desc).limit(5)
    @top_teams = Team.where.not(name: 'No Team').order(raised: :desc).limit(5)
    
    @total_raised = Event.all.pluck(:raised).sum
  end
  
  def privacy
    
  end
  
  def attendees
    @attendees = Attendee.all.order(raised: :desc)
  end
  
  def about 
    
  end

end