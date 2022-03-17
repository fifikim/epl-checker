require_relative 'ids'

class Parse
  def self.table(data)
    data = data["response"][0]["league"]["standings"][0]

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
  end

  def self.match(match)
    league_id = match["league"]["id"]
    round_desc = match["league"]["round"]
    season_week = round_desc.split(" - ")
    round_desc = "#{season_week[0]} - Week #{season_week[1]}" if league_id == 39 

    parsed_match = {
      time: match["fixture"]["date"].split("T")[1].split("+")[0],
      tie: "#{match["teams"]["home"]["name"]} vs. #{match["teams"]["away"]["name"]}".ljust(22),
      league: "#{Ids.leagues[league_id]}".ljust(4),
      round: round_desc,
    }
  end
end