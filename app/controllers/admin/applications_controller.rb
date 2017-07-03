class Admin::ApplicationsController < ApplicationController
  layout "admin"
  before_action :require_user, :require_admin

  def index
    @apps = Application.all
  end

  def show
    @app = Application.find(params[:id])
  end
end