class Fetch 
  def self.table
    Fetch.fetch("/standings?league=39&season=2021")
  end

  def self.matches(daterange)
    today = Date.today
    til_sun = 6 - today.wday + 1

    case daterange
      when "today" then Fetch.fetch("/fixtures?date=#{today}")
      when "tomorrow" then Fetch.fetch("/fixtures?date=#{today + 1}")
      when "this week" then Fetch.fetch("/fixtures?league=39&season=2021&from=#{today}&to=#{today + til_sun}")
      when "this weekend" then Fetch.fetch("/fixtures?league=39&season=2021&from=#{today + til_sun - 1}&to=#{today + til_sun}")
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
      response.parsed_response
    end
  end

end