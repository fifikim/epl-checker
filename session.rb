# require 'httparty'
# require 'json'
# require 'date'
# require_relative 'keys'
# require_relative 'parse'
# require_relative 'ids'

# class Session
#   def initialize(data_file)
#     @data = data_file
#     @epl_sides = [33, 34, 38, 39, 40, 41, 42, 44, 45, 46, 47, 48, 49, 50, 51, 52, 55, 63, 66, 71]
#   end

#   def greeting
#     "Welcome to EPL Checker!\n\n"
#   end

#   def call(url) 
#     apikey = Keys.apikey
#     HTTParty.get(url, :headers => { 'x-rapidapi-host': 'v3.football.api-sports.io', 'x-rapidapi-key': apikey })
#   end

#   def fetch(type)
#     base_url = "https://v3.football.api-sports.io"

#     case type
#       when "standings" then endpoint = "/standings?league=39&season=2021"
#       when "matches today" then endpoint = "/fixtures?date=#{Date.today}"
#       when "schedule" 
#       # when "tottenham matches" then endpoint = 
#     end

#     response = call("#{base_url}#{endpoint}")

#     if response.code != 200
#       puts "fetch failed"
#     else
#       data = response.parsed_response
#       case type
#         when "standings" then get_standings(data["response"][0]["league"]) 
#         when "matches today" then get_matches_today(data["response"]) 
#         when "spurs matches" then get_spurs(data["response"])
#       end
#     end
#   end

#   def get_standings(data)
#     puts "\n\nCurrent Standings: #{data["name"]}\n # | Name                 | MP |  W |  D |  L | GF | GA |  GD |  P " 
#     teams = data["standings"][0]

#     teams.each do |unformatted_team|
#       team = Parse.standing(unformatted_team)
#       puts "#{team[:rank]} | #{team[:name]} | #{team[:played]} | #{team[:wins]} | #{team[:draws]} | #{team[:losses]} | #{team[:gf]} | #{team[:ga]} | #{team[:gd]} | #{team[:points]} "
#     end
#   end

#   def get_matches_today(matches)
#     puts "\nAll matches today (#{Date.today}) featuring Premiere League sides:"

#     pl_matches = matches.select { |match| @epl_sides.include?(match["teams"]["home"]["id"]) || @epl_sides.include?(match["teams"]["away"]["id"]) }
#     # puts JSON.pretty_generate(pl_matches)

#     pl_matches.each do |unformatted_match|
#       match = Parse.match(unformatted_match)
#       puts "#{match[:time]} | #{match[:tie]} | #{match[:league]} | #{match[:round]}"
#     end
#   end

#   def get_schedule(club)

#   end

#   # def get_clubs(clubs)
#   #   # puts "clubs:"
#   #   # puts JSON.pretty_generate(clubs)
#   #   puts Ids.clubs[47]
#   # end

#   def farewell
#     "Thanks for using EPL Checker. Good bye."
#   end
# end



require 'httparty'
require 'json'
require 'date'
require_relative 'keys'
require_relative 'parse'
require_relative 'ids'

class Session
  def initialize(data_file)
    @data = data_file
  end

  def greeting
    "Welcome to EPL Checker!\n\n"
  end

  def fetch(endpoint) 
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

  def query(type)
    case type
      when "table" then get_table
      # when "matches today" then get_matches_today(data["response"]) 
      # when "spurs matches" then get_spurs(data["response"])
    end
  end

  def get_table
    data = fetch("/standings?league=39&season=2021")
    format_table(data)
  end

  def format_table(data)
    puts "\nCurrent Standings: #{data["name"]}\n # | Name                 | MP |  W |  D |  L | GF | GA |  GD |  P " 
    teams = Parse.table(data)

    teams.each do |team|
      puts "#{team[:rank]} | #{team[:name]} | #{team[:played]} | #{team[:wins]} | #{team[:draws]} | #{team[:losses]} | #{team[:gf]} | #{team[:ga]} | #{team[:gd]} | #{team[:points]} "
    end
  end

  def get_matches_today(matches)
    endpoint = "/fixtures?date=#{Date.today}"
    puts "\nAll matches today (#{Date.today}) featuring Premiere League sides:"
    epl_sides = Ids.club_names.keys
    pl_matches = matches.select { |match| epl_sides.include?(match["teams"]["home"]["id"]) || epl_sides.include?(match["teams"]["away"]["id"]) }

    pl_matches.each do |unformatted_match|
      match = Parse.match(unformatted_match)
      puts "#{match[:time]} | #{match[:tie]} | #{match[:league]} | #{match[:round]}"
    end
  end

  def format_matches_today(matches)
    puts "\nAll matches today (#{Date.today}) featuring Premiere League sides:"
    epl_sides = Ids.club_names.keys
    pl_matches = matches.select { |match| epl_sides.include?(match["teams"]["home"]["id"]) || epl_sides.include?(match["teams"]["away"]["id"]) }

    pl_matches.each do |unformatted_match|
      match = Parse.match(unformatted_match)
      puts "#{match[:time]} | #{match[:tie]} | #{match[:league]} | #{match[:round]}"
    end
  end

  def get_schedule(club)
  end

  def farewell
    "Thanks for using EPL Checker. Good bye."
  end
end


