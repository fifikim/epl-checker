require_relative 'ids'

class Fetch 
  def self.table
    Fetch.fetch("/standings?league=39&season=2021")
  end

  def self.matches(daterange)
    today = Date.today
    til_sun = 6 - today.wday + 1
    leagues = Ids.leagues.keys 

    if daterange == "today" then Fetch.fetch("/fixtures?date=#{today}")
    elsif daterange == "tomorrow" then Fetch.fetch("/fixtures?date=#{today + 1}")
    else
      matches = []
      startday = today if daterange == "this week" 
      startday = today + til_sun - 1 if daterange == "this weekend" 
      leagues.each do |league_id|
        results = Fetch.fetch("/fixtures?league=#{league_id}&season=2021&from=#{startday}&to=#{today + til_sun}") 
        matches.concat(results)
      end
      matches
    end 
  end

  def self.schedule(club_id)
    Fetch.fetch("/fixtures?team=#{club_id}&season=2021&from=#{Date.today}&to=2022-06-01")
  end

  def self.fetch(endpoint) 
    base_url = "https://v3.football.api-sports.io"
    url = "#{base_url}#{endpoint}"
    apikey = Keys.apikey

    response = HTTParty.get(url, :headers => { 'x-rapidapi-host': 'v3.football.api-sports.io', 'x-rapidapi-key': apikey })

    if response.code != 200
      puts "fetch failed"
    else
      res = response.parsed_response
      res["response"]
    end
  end

end