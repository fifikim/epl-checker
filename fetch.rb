class Fetch 
  def self.table
    Fetch.fetch("/standings?league=39&season=2021")
  end

  def self.matches(daterange)
    case daterange
      when "today" then date = Date.today
      when "tomorrow" then date = Date.today + 1
      # when "week" then date =  # today through sunday
      # when "weekend" then date =  # saturday and sunday of current week
    end 
    Fetch.fetch("/fixtures?date=#{date}")
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