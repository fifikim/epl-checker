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
    type = type.split
    query = type.shift
    option = type.join(" ")
    case query
      when "table" then get_table
      when "matches" then get_matches(option)
      when "schedule" then get_schedule(option)
    end
  end

  def get_table
    data = Fetch.table
    Format.table(data)
  end

  def get_matches(daterange)
    data = Fetch.matches(daterange)
    Format.matches(daterange, data)
  end

  def get_schedule(club)
    club_id = Ids.club_ids.select { |names, id| names.include?(club) }[0][1]
    data = Fetch.schedule(club_id)
    Format.schedule(club_id, data)
  end

  def farewell
    "Thanks for using EPL Checker. Good bye."
  end
end


