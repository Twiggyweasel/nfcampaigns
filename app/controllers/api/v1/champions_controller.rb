class Api::V1::ChampionsController < ApplicationController

  def index
    champions = Champion.order(:created_at)

    render json: champions
  end

end