class Ids
  attr_accessor :leagues, :clubs
  
  def self.leagues
    leagues = {
      39 => "PL",
      2 => "UCL",
      848 => "UECL",
      45 => "FA",
      48 => "EFL",
    }
  end

  def self.clubs
    clubs = {
      33 => "Manchester United", 
      34 => "Newcastle", 
      38 => "Watford", 
      39 => "Wolves", 
      40 => "Liverpool", 
      41 => "Southampton", 
      42 => "Arsenal", 
      44 => "Burnley", 
      45 => "Everton", 
      46 => "Leicester", 
      47 => "Tottenham", 
      48 => "West Ham", 
      49 => "Chelsea", 
      50 => "Manchester City", 
      51 => "Brighton", 
      52 => "Crystal Palace", 
      55 => "Brentford", 
      63 => "Leeds", 
      66 => "Aston Villa", 
      71 => "Norwich",
    }
  end

end