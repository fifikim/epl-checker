require_relative 'parse'
require_relative 'ids'

class Format 
  def self.matches(daterange, data)
    pl_matches = Parse.matches(data)
    case daterange
      when "today" then date = Date.today
      when "tomorrow" then date = Date.today + 1
      # when "this week" then date =  # today through sunday
      # when "this weekend" then date =  # saturday and sunday of current week
    end 
    puts "\nAll matches #{daterange} (#{date}) featuring Premiere League sides:" 
    pl_matches.each { |match| puts "#{match[:time]} | #{match[:tie]} | #{match[:league]} | #{match[:round]}" }
  end

  def self.table(data)
    teams = Parse.table(data)
    puts "\nCurrent Standings: #{data["name"]}\n # | Name                 | MP |  W |  D |  L | GF | GA |  GD |  P " 
    teams.each do |team|
      puts "#{team[:rank]} | #{team[:name]} | #{team[:played]} | #{team[:wins]} | #{team[:draws]} | #{team[:losses]} | #{team[:gf]} | #{team[:ga]} | #{team[:gd]} | #{team[:points]} "
    end
  end

  def self.schedule(club_id, data)
    matches = Parse.schedule(data)
    club_name = Ids.club_names[club_id]
    puts "\nUpcoming matches featuring #{club_name}:" # look up name by id
    matches.each { |match| puts "#{match[:date]} | #{match[:time]} | #{match[:tie]} | #{match[:league]} | #{match[:round]}" }
  end

end

