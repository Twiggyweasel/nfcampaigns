class Admin::ApplicationsController < ApplicationController
  layout "admin"
  before_action :require_user, :require_admin
  def index
    @apps = Application.all
  end
end