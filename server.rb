require 'sinatra'
require 'csv'
require 'pry'

#extract csv file and return array of player information
def export_csv(filename)
  teams = []
  CSV.foreach(filename, headers: true) do |row|
    teams << row.to_hash
  end
  teams
end

#create array of unique teams, no repetition
def unique_teams(teams)
  teams.map {|player_info| player_info["team"]}.uniq
end

#create array of hashes containing first_name, last_name, position for people on a specific team
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

#=====================================================

#display homepage with clickable team links
get '/' do
  teams = export_csv('./public/lackp_starting_rosters.csv')
  @team_list = unique_teams(teams)
  erb :index
end

get '/teams/:team_name' do
  @team_title = params[:team_name]
  teams = export_csv('./public/lackp_starting_rosters.csv')
  #array of hashes containing first_name, last_name, position for people on a specific team
  @team_members = team_member_list(teams, @team_title)
  erb :show
end
