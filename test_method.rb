require 'csv'
require 'pry'

def export_csv(filename)
  teams = []
  CSV.foreach(filename, headers: true) do |row|
    teams << row.to_hash
  end
  teams
end

def unique_teams(teams)
  team_list = []
  teams.each do |player_info|
    while !team_list.include?(player_info["team"]) #team is not in array
      team_list << player_info["team"]
    end
  end
  team_list
end

def unique_teams(teams)
  teams.map {|player_info| player_info["team"]}.uniq
end


def team_member_list(teams, team_title)
  team_members = []
  teams.each do |player_info|
    if team_title == player_info["team"]
                      #create a hash containing first_name, last_name, position to be put into team_member array
      team_members << {first_name: player_info["first_name"], last_name: player_info["last_name"], position: player_info["position"]}
    end
  end
  team_members
end


teams = export_csv('./public/lackp_starting_rosters.csv')

puts unique_teams(teams)
