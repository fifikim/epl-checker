require 'httparty'
require 'json'
require_relative 'keys'
require_relative 'parse'

class Session
  def initialize(data_file)
    @data = data_file
    @epl_sides = [33, 34, 38, 39, 40, 41, 42, 44, 45, 46, 47, 48, 49, 50, 51, 52, 55, 63, 66, 71]
    @leagues = {
      39 => "PL",
      2 => "UCL",
      848 => "UECL",
      45 => "FA",
      48 => "EFL",
    }
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
      when "matches today" then endpoint = "/fixtures?date=2022-03-16" 
    end

    response = call("#{base_url}#{endpoint}")

    if response.code != 200
      puts "fetch failed"
    else
      data = response.parsed_response["response"]

      case type
        when "standings" then get_standings(data[0]["league"]) 
        when "matches today" then get_matches_today(data) 
      end
    end
  end

  def get_standings(data)
    puts "\n\nCurrent Standings: #{data["name"]}\n # | Name                 | MP |  W |  D |  L | GF | GA |  GD |  P " 
    teams = data["standings"][0]

    teams.each do |unformatted_team|
      team = Parse.standing(unformatted_team)
      puts "#{team[:rank]} | #{team[:name]} | #{team[:played]} | #{team[:wins]} | #{team[:draws]} | #{team[:losses]} | #{team[:gf]} | #{team[:ga]} | #{team[:gd]} | #{team[:points]} "
    end
  end

  def get_matches_today(matches)
    puts "\nAll matches today featuring PL sides:"
    pl_matches = matches.select { |match| @epl_sides.include?(match["teams"]["home"]["id"]) || @epl_sides.include?(match["teams"]["away"]["id"]) }

    pl_matches.each do |unformatted_match|
      match = Parse.match(unformatted_match)
      puts "#{match[:time]} | #{match[:tie]} | #{match[:league]} | #{match[:round]}"
    end

  end

  def farewell
    "Thanks for using EPL Checker. Good bye."
  end
end


