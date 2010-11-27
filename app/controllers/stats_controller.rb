class StatsController < ApplicationController
  def index
    @player = PlayerStats.find(:id)
  end

end
