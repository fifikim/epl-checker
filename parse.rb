class Parse
  def self.standing(team)
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

  def self.match(match)
    leagues = {
      39 => "PL",
      2 => "UCL",
      848 => "UECL",
      45 => "FA",
      48 => "EFL",
    }
    parsed_match = {
      time: match["fixture"]["date"].split("T")[1].split("+")[0],
      tie: "#{match["teams"]["home"]["name"]} vs. #{match["teams"]["away"]["name"]}".ljust(22),
      league: leagues[match["league"]["id"]].ljust(4),
      round: match["league"]["round"],
    }
  end
end