class Admin::ContributionsController < ApplicationController
  layout 'admin'
  before_action :set_event, except: [:new, :create]
  before_action :context, only: [:create]
  before_action :require_user, :require_admin


  def index

    # @search = @event.contributions.ransack(params[:q])
    # @contributions = @search.result(distinct: true).includes(:user).page(params[:page])

    @contributions = Contribution.where(backable: @event).page params[:page]

    respond_to do |format|
      format.js
      format.html
    end
  end

  def new
    @contribution = context.contributions.new
  end


  def create
    # @event = Event.find_by_title(params[:event_id])
    @contribution = context.contributions.create(contribution_params)

    respond_to do |format|
      if @contribution.save
        format.html { redirect_to admin_event_contributions_path(@event), :flash => { :success => "Donation Created" } }
        format.js

      else
        format.js
      end
    end
  end


  private
    def set_event
      @event = Event.find_by_title(params[:event_id])
    end

    def context
      if params[:contribution][:context] == "Attendee"
        Attendee.find(params[:contribution][:backable])
      elsif params[:contribution][:context] == "Event"
        Event.find_by_title(params[:contribution][:event_title])
      end
      # if params[:event_id]
      #   id = params[:event_id]
      #   Event.find_by_title(params[:event_id])
      # elsif params[:attendee_id]
      #   id = params[:attendee_id]
      #   Attendee.find(params[:attendee_id])
      # elsif params[:champion_id]
      #   id = params[:champion_id]
      #   Champion.find(params[:champion_id])
      # else
      #   id = params[:team_id]
      #   Team.find(params[:team_id])
      # end
    end

    def contribution_params
      params.require(:contribution).permit(:amount, :honoree, :category, :paid, :user_id)
    end

end