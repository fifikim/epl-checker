require_relative 'parse'
require_relative 'ids'

class Format 
  def self.matches(daterange, data)
    pl_matches = Parse.matches(data)
    today = Date.today
    til_sun = 6 - today.wday + 1
    case daterange
      when "today" then date = today
      when "tomorrow" then date = today + 1
      when "this week" then date = "#{today} through #{today + til_sun}"
      when "this weekend" then date = "#{today + til_sun - 1} through #{today + til_sun}"
    end 
    puts "\nAll matches #{daterange} (#{date}) featuring Premiere League sides:" 
    pl_matches.sort_by { |hsh| hsh[:date] }.each { |match| puts "#{match[:date]} | #{match[:time]} | #{match[:tie]} | #{match[:league]} | #{match[:round]}" }
    
  end

  def self.table(data)
    teams = Parse.table(data)
    puts "\nCurrent Standings: \n # | Name                 | MP |  W |  D |  L | GF | GA |  GD |  P " 
    teams.each do |team|
      puts "#{team[:rank]} | #{team[:name]} | #{team[:played]} | #{team[:wins]} | #{team[:draws]} | #{team[:losses]} | #{team[:gf]} | #{team[:ga]} | #{team[:gd]} | #{team[:points]} "
    end
  end

  def self.schedule(club_id, data)
    matches = Parse.schedule(data)
    club_name = Ids.club_names[club_id]
    puts "\nUpcoming matches featuring #{club_name}:" 
    matches.each { |match| puts "#{match[:date]} | #{match[:time]} | #{match[:tie]} | #{match[:league]} | #{match[:round]}" }
  end

end

