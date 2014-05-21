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
  team_list = []
  teams.each do |player_info|
    while !team_list.include?(player_info["team"]) #team is not in array
      team_list << player_info["team"]
    end
  end
  team_list
end

#create array of hashes containing first_name, last_name, position for people on a specific team
def team_member_list(teams, team_url)
  team_members = []
  teams.each do |player_info|
    if team_url == player_info["team"].delete(' ')
                      #create a hash containing first_name, last_name, position to be put into team_member array
      team_members << {first_name: player_info["first_name"], last_name: player_info["last_name"], position: player_info["position"]}
    end
  end
  team_members
end

def team_title(team_list, team_url)
  title = ""
  team_list.each do |team|
    if team_url == team.delete(' ')
      title = team
    end
  end
  title
end

#=====================================================

#display homepage with clickable team links
get '/' do*
  @teams = export_csv('lackp_starting_rosters.csv')
  @team_list = unique_teams(@teams)
  erb :index
end

get '/teams/:team_name' do
  @team_url = params[:team_name]
  @teams = export_csv('lackp_starting_rosters.csv')
  @team_list = unique_teams(@teams)
  #array of hashes containing first_name, last_name, position for people on a specific team
  @team_members = team_member_list(@teams, @team_url)
  @title = team_title(@team_list, @team_url)
  erb :show
end


# These lines can be removed since they are using the default values. They've
# been included to explicitly show the configuration options.
set :views, File.dirname(__FILE__) + '/views'
set :public_folder, File.dirname(__FILE__) + '/public'

