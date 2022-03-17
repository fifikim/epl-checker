require 'httparty'
require 'json'
require 'date'
require_relative 'keys'
require_relative 'parse'
require_relative 'ids'
require_relative 'fetch'
require_relative 'format'

class Session
  def initialize(data_file)
    @data = data_file
  end

  def greeting
    "Welcome to EPL Checker!\n\n"
  end

  def query(type)
    type.delete("this ")
    query, option = type.split
    case query
      when "table" then get_table
      when "matches" then get_matches(option)
      when "schedule" then get_schedule(option)
    end
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

  def get_table
    data = fetch("/standings?league=39&season=2021")
    Format.table(data)
  end

  def get_matches(daterange)
    case daterange
      when "today" then date = Date.today
      # when "tomorrow" then date = 

      # week: today through sunday
      # when "week" then date =

      # weekend: saturday and sunday of current week
      # when "weekend" then date = 
    end 

    data = fetch("/fixtures?date=#{date}")
    # data = Fetch.matches(date)
    Format.matches(date, data)
  end

  # def get_schedule(club)
  #   club_id = Ids.club_ids.scan(club)
  #   data = fetch("/fixtures?date=#{date}")
  #   # data = Fetch.schedule(cl)
  #   Format.schedule(data)
  # end

  # def format_schedule(data)
  #   pl_matches = Parse.matches(data)
  #   pl_matches.each { |match| puts "#{match[:time]} | #{match[:tie]} | #{match[:league]} | #{match[:round]}" }
  # end

  def farewell
    "Thanks for using EPL Checker. Good bye."
  end
end


