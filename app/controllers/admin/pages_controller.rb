class Admin::PagesController < ApplicationController
  layout 'admin'
  before_action :require_user, :require_admin
  
  def home
    @events = Event.all.limit(3)
  end
  
end