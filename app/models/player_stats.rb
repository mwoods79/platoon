require 'open-uri'
class PlayerStats
  def self.find(id)
    doc = Nokogiri::HTML(open("http://www.bungie.net/Stats/Reach/CareerStats/default.aspx?player=#{CGI.escape(id.to_s)}&vc=3"))
    player = Hash.new
    
    player[:kills] = doc.css('#ctl00_mainContent_killsLabel').first.content
    player[:deaths] = doc.css('#ctl00_mainContent_deathsLabel').first.content
    player[:games_played] = doc.css('ul.legend li.number').first.content
    player[:kd] = (player[:kills].gsub(',', '').to_f / player[:deaths].gsub(',', '').to_f)
    
    player
  end
end