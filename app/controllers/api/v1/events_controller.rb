class Api::V1::EventsController < ApplicationController

  def index
    events = Event.is_viewable.order(:event_date)

    render json: events
  end

end