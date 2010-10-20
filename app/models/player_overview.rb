require 'open-uri'
class PlayerOverview
    
  def find(id)
    doc = Nokogiri::HTML(open("http://www.bungie.net/Stats/Reach/default.aspx?player=#{CGI.escape(id.to_s)}"))
    player = Hash.new
    player[:rank] = doc.css('span#ctl00_mainContent_identityBar_currentGlobalRankLabel, .current').first.content
    player[:games_played] = doc.css('span#ctl00_mainContent_gamesPlayedLabel').first.content
    player[:last_played] = doc.css('span#ctl00_mainContent_lastPlayedLabel').first.content
    
    player
  end
  
end