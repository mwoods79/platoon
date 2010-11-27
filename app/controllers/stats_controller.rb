class StatsController < ApplicationController
  def index
    @player = PlayerStats.find(:id)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @player }
      format.json { render :json => @player}
    end
  end

end
