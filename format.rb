require_relative 'parse'

class Format 
  def self.matches(date, data)
    pl_matches = Parse.matches(data)
    puts "\nAll matches today (#{date}) featuring Premiere League sides:" 
    pl_matches.each { |match| puts "#{match[:time]} | #{match[:tie]} | #{match[:league]} | #{match[:round]}" }
  end

  def self.schedule(data)
    puts "\nUpcoming matches featuring #{club}:" 
  end

  def self.table(data)
    puts "\nCurrent Standings: #{data["name"]}\n # | Name                 | MP |  W |  D |  L | GF | GA |  GD |  P " 
    teams = Parse.table(data)

    teams.each do |team|
      puts "#{team[:rank]} | #{team[:name]} | #{team[:played]} | #{team[:wins]} | #{team[:draws]} | #{team[:losses]} | #{team[:gf]} | #{team[:ga]} | #{team[:gd]} | #{team[:points]} "
    end
  end

end

