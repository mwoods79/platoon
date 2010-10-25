require 'open-uri'
class PlayerOverview
    
  def self.find(id)
    doc = Nokogiri::HTML(open("http://www.bungie.net/Stats/Reach/default.aspx?player=#{CGI.escape(id.to_s)}"))
    player = Hash.new
    
    rank = doc.css('span#ctl00_mainContent_identityBar_currentGlobalRankLabel, .current').first
    player[:rank] = rank.content unless rank == nil
    
    games_played = doc.css('span#ctl00_mainContent_gamesPlayedLabel').first
    player[:games_played] = games_played.content unless games_played == nil
    
    last_played = doc.css('span#ctl00_mainContent_lastPlayedLabel').first
    player[:last_played] = last_played.content unless last_played == nil
    
    armor_completion = doc.css('span#ctl00_mainContent_armorCompletionLabel').first
    player[:armor_completion] = armor_completion.content unless armor_completion == nil
    
    daily_challenges = doc.css('span#ctl00_mainContent_dailyChallengesLabel').first
    player[:daily_challenges] = daily_challenges.content unless daily_challenges == nil
    
    weekly_challenges = doc.css('span#ctl00_mainContent_weeklyChallengesLabel').first
    player[:weekly_challenges] = weekly_challenges.content unless weekly_challenges == nil
    
    weekly_challenges = doc.css('span#ctl00_mainContent_weeklyChallengesLabel').first
    player[:weekly_challenges] = weekly_challenges.content unless weekly_challenges == nil
    
    
    doc = Nokogiri::HTML(open("http://www.bungie.net/Stats/Reach/PlayerGameHistory.aspx?player=#{CGI.escape(id.to_s)}"))
    games = doc.css('td .score')
    game_dates = doc.css('td .date')
    
    games_today = 0
    todays_kills = 0;
    dateDiff = 0.0
    unless games == nil
      games.each do |game|
        dateDiff = getdate(game_dates[games_today].content)
        if (Time.now - dateDiff) < (60.0 * 60.0 * 24.0)
          games_today += 1
          todays_kills += game.content.to_i
        end
      end
    end
    
    player[:games_today] = games_today
    player[:todays_kills] = todays_kills
    
    player[:last_game_date] = nil
    if game_dates.length > 0
      player[:last_game_date] = getdate(game_dates.first.content)
    end
    
    player
  end
  
  def self.getdate(input)
    dateArray = /(\d{1,2})\.(\d{1,2})\.(\d{4})\s(\d{1,2}):(\d{2})\s([A-Za-z]{2})/.match(input)
    hour = 0;
    time = nil
    if dateArray != nil and (dateArray.length == 4 or dateArray.length == 7)
      hour = dateArray[4].to_i
      hour += 12 if dateArray[6].to_s == "PM"
      time = Time.new(dateArray[3], dateArray[1], dateArray[2], hour, dateArray[5], 0)
    end
    time
  end
  
end