require_relative 'ids'

class Parse
  def self.table(data)
    data = data[0]["league"]["standings"][0]
    teams = data.map do |team|
      goalsf = team["all"]["goals"]["for"].to_i
      goalsa = team["all"]["goals"]["against"].to_i

      parsed_team = {
        rank: team["rank"].to_s.rjust(2),
        name: team["team"]["name"].ljust(20),
        played: team["all"]["played"].to_s.rjust(2),
        wins: team["all"]["win"].to_s.rjust(2),
        draws: team["all"]["draw"].to_s.rjust(2),
        losses: team["all"]["lose"].to_s.rjust(2),
        gf: goalsf.to_s.rjust(2),
        ga: goalsa.to_s.rjust(2),
        gd: (goalsf - goalsa).to_s.rjust(3),
        points: team["points"].to_s.rjust(2),
      }
    end
    # puts teams
  end

  def self.matches(data)
    epl_sides = Ids.club_names.keys
    pl_matches = data.select { |match| epl_sides.include?(match["teams"]["home"]["id"]) || epl_sides.include?(match["teams"]["away"]["id"]) }
    Parse.schedule(pl_matches)
  end

  def self.schedule(data)
    lengths = []
    matches = data.map do |match|
      league_id = match["league"]["id"]
      round_desc = match["league"]["round"]
      season_week = round_desc.split(" - ")
      round_desc = "#{season_week[0]} - Week #{season_week[1]}" if league_id == 39 
      home = match["teams"]["home"]["name"]
      away = match["teams"]["away"]["name"]
      lengths << home.length + away.length

      parsed_match = {
        date: match["fixture"]["date"].split("T")[0],
        time: match["fixture"]["date"].split("T")[1].split("+")[0],
        tie: "#{home} vs. #{away}",
        league: "#{Ids.leagues[league_id]}".ljust(4),
        round: round_desc,
      }
    end

    matches = matches.each do |match| 
      tie = match[:tie]
      match[:tie] = tie.ljust(lengths.max + 6)
    end 
  end


end