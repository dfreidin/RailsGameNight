require 'open-uri'

class GamesController < ApplicationController

    @@bgg_url = "https://boardgamegeek.com/xmlapi2/"

    def home
        @home = true
        @games = get_games_data @user.games.reduce([]) {|arr, g| arr += [g.bgg_id]}
    end

    def profile
        redirect_to home_path unless User.exists?(id: params[:id])
        @profile_user = User.find(params[:id])
        @games = get_games_data @profile_user.games.reduce([]) {|arr, g| arr += [g.bgg_id]}
    end

    def group
        redirect_to home_path unless Group.exists?(id: params[:id])
        @group = Group.find(params[:id])
        @games = get_games_data @group.members.reduce([]) {|arr, m| arr += m.games}.uniq.map {|g| g.bgg_id}
    end

    def search_games
        results = Nokogiri::XML(open(@@bgg_url + "search?query=" + params[:bgg_query]))
        bgg_ids = []
        results.xpath("//item").each {|i| bgg_ids += [i["id"]] if i["type"] == "boardgame"}
        @games_data = get_games_data bgg_ids
        render "search_table", layout: false
    end

    def create
        params[:add_games].each  {|bgg_id| @user.games += [Game.find_or_create_by(bgg_id: bgg_id[0])]}
        redirect_to home_path
    end

    def rate
        @game = Game.find_by(bgg_id: params[:bgg_id]) if Game.exists?(bgg_id: params[:bgg_id])
        rating = Rating.find_or_create_by(user: @user, game: @game)
        if rating && rating.update(rating: params[:rating])
            render text: "Rating successfully updated"
        else
            render text: "Something went wrong..."
        end
    end

    def delete
        game = Game.find_by(bgg_id: params[:bgg_id]) if Game.exists?(bgg_id: params[:bgg_id])
        @user.games.delete(game) if game
        redirect_to home_path
    end

    private
    def get_games_data bgg_ids
        url = @@bgg_url + "thing?id=" + bgg_ids.join(",")
        games_xml = Nokogiri::XML(open(url))
        games_data = []
        games_xml.xpath("//item").each do |i|
            bgg_id = i["id"]
            name = i.xpath("name")[0]["value"]
            thumb = i.xpath("thumbnail")[0].content if i.xpath("thumbnail")[0]
            game = Game.find_by(bgg_id: bgg_id) if Game.exists?(bgg_id: bgg_id)
            user_rating = Rating.find_by(game: game, user: @user).rating if game && Rating.exists?(game: game, user: @user)
            group_rating = game.group_rating(@group) if @group
            games_data += [{bgg_id: bgg_id, name: name, thumb: thumb, user_rating: user_rating, group_rating: group_rating}]
        end
        games_data.sort_by! {|g| g[:name]}
        games_data.sort_by! {|g| g[:group_rating].to_f}.reverse! if @group
        games_data
    end
end
