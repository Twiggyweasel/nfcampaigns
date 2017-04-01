class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.order(:event_date)
    # .includes(:contributions)
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @top_fundraisers = @event.attendees.where.not(raised: 0, user_id: 1 ).order(raised: :desc).limit(5)
    @top_teams = @event.teams.where.not(raised: 0, id: @event.teams.first.id).order(raised: :desc).limit(5)
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, :flash[:success] = 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, :flash => { :success => 'Event was successfully updated.' } }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def registration_select
    @event = Event.find_by_title(params[:event_id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find_by_title(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :event_cover, :registration_date, :event_date, :event_start_time, :goal, :raised, :venue_name, :street, :city, :state, :zipcode, :has_shirts, :is_private, size_ids: [])
    end
end
