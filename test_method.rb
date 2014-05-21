require 'csv'
require 'pry'

def unique_teams(teams)
  team_list = []
  teams.each do |player_info|
    while !team_list.include?(player_info["team"]) #team is not in array
      team_list << player_info["team"]
    end
  end
  team_list
end

def export_csv(filename)
  teams = []
  CSV.foreach(filename, headers: true) do |row|
    teams << row.to_hash
  end
  teams
end

teams = export_csv('lackp_starting_rosters.csv')

puts unique_teams(teams)
