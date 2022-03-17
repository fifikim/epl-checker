class Ids
  attr_accessor :leagues, :club_names, :club_ids
  
  def self.leagues
    leagues = {
      39 => "PL",
      2 => "UCL",
      3 => "UEL",
      848 => "UECL",
      45 => "FA",
      48 => "EFL",
    }
  end

  def self.club_names
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

  def self.club_ids
    names = [
      [["man", "mufc", "man united", "manchester united"], 33],
      [["newcastle", "nufc", "new"], 34],
      [["watford", "wat"], 38],
      [["wolves", "wol"], 39], 
      [["liverpool", "lfc", "reds", "liv"], 40],
      [["southampton", "sou", "soton"], 41], 
      [["arsenal", "ars", "afc"], 42], 
      [["burnley", "bur", "bfc"], 44],
      [["everton", "eve", "efc"], 45], 
      [["leicester", "lei", "foxes", "lcfc"], 46],
      [["tot", "thfc", "spurs", "tottenham"], 47], 
      [["west ham", "irons", "whu"], 48], 
      [["chelsea", "cfc", "blues", "che"], 49],
      [["mcfc", "mcu", "man city", "manchester city"], 50],
      [["brighton", "bha"], 51], 
      [["crystal palace", "cry", "palace"], 52],
      [["brentford", "bre"], 55], 
      [["leeds", "lee", "lufc"], 63], 
      [["aston villa", "villa", "avfc"], 66],
      [["norwich", "nor"], 71],
    ]
  end

end