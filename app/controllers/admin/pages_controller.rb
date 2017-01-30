class Admin::PagesController < ApplicationController
  layout 'admin'
  def home
    @events = Event.all.limit(3)
  end
  
end