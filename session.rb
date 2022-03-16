require 'httparty'
require_relative 'keys'

class Session
  def initialize(data_file)
    @data = data_file
  end

  def greeting
    "Welcome to EPL Checker!\n\n"
  end

  def call(url) 
    apikey = Keys.apikey
    HTTParty.get(url, :headers => { 'x-rapidapi-host': 'v3.football.api-sports.io', 'x-rapidapi-key': apikey })
  end

  def fetch(type)
    base_url = "https://v3.football.api-sports.io"

    case type
      when "standings" then endpoint = "/standings?league=39&season=2021"
      when "matches today" then endpoint = "/standings?league=39&season=2021" 
    end

    response = call("#{base_url}#{endpoint}")

    if response.code != 200
      puts "fetch failed"
    else
      data = response.parsed_response

      case type
        when "standings" then get_standings(data["response"][0]["league"]) 
        when "matches today" then get_matches_today(data) 
      end

    end
  end

  def get_standings(data)
    puts "\n\nCurrent Standings: #{data["name"]}"
    puts " # | Name                 | MP |  W |  D |  L | GF | GA |  GD | P " 
    teams = data["standings"][0]

    teams.each do |team|
      gf = team["all"]["goals"]["for"].to_i
      ga = team["all"]["goals"]["against"].to_i
      puts "#{team["rank"].to_s.rjust(2)} | #{team["team"]["name"].ljust(20)} | #{team["all"]["played"].to_s.rjust(2)} | #{team["all"]["win"].to_s.rjust(2)} | #{team["all"]["draw"].to_s.rjust(2)} | #{team["all"]["lose"].to_s.rjust(2)} | #{team["all"]["goals"]["for"].to_s.rjust(2)} | #{team["all"]["goals"]["against"].to_s.rjust(2)} | #{(gf - ga).to_s.rjust(3)} | #{team["points"].to_s.rjust(2)} " 
    end
  end

  def get_matches_today(data)
    puts "\n\nMatches Today: <<date>>"
  end
      

  def farewell
    "Thanks for using EPL Checker. Good bye."
  end
end


