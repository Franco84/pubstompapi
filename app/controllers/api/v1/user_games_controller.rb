class Api::V1::UserGamesController < ApplicationController
  before_action :authenticate_user?

    #  NO USE CURRENTLY
    # def index
    #   @user_games = UserGame.all
    #   render json: @user_games, each_serializer: UserGameSerializer
    # end

    # def show
    #   @user_game = UserGame.find(params[:id])
    #   render json: @user_game, serializer: UserGameSerializer
    # end

    def my_list
      @user = get_current_user
      if @user
        favorites = UserGame.where(user_id: @user.id).map {|fav| fav.game.game_id }
        render json: favorites
      else
        render json: {
          error: "Favorite Games Currently Unaccessible",
          status: 400
        }, status: 400
      end
    end

    def toggle
      @user = get_current_user
      Game.find_or_create_by(game_id: user_game_params[:game_id]) do |game|
          game.cover_url = user_game_params[:cover_url]
          game.name = user_game_params[:name]
          game.save
        end
      @game = Game.where(game_id: user_game_params[:game_id])
      @user_game = UserGame.where(game_id: @game[0].id).where(user_id: @user.id)
      if @user_game.length > 0
        @user_game[0].destroy
        favorites = UserGame.where(user_id: @user.id).map {|fav| fav.game.game_id }
        render json: favorites
      else
        UserGame.create(game_id: @game[0].id, user_id: @user.id)
        favorites = UserGame.where(user_id: @user.id).map {|fav| fav.game.game_id }
        render json: favorites
      end
      # @user_game = UserGame.new(user_id: @user.id, game_id: @game.id)
      # if @user_game.save
      #   render json: UserGame.where(user_id: @user.id)
      # else
      #   render json: {
      #     error: "Game could not be added to User\'s list",
      #     status: 400
      #   }, status: 400
      # end
    end

    # NO CURRENT USE
    # def update
    #   if @user_game.update(user_game_params)
    #     render json: @user_game, serializer: UserGameSerializer
    #   else
    #     render json: @user_game.errors, status: 400
    #   end
    # end

    def destroy
      if @user_game.destroy
        render json: { message: 'Game was removed from User\' list successfully.' }
      else
        render json: @profile.errors, status: 400
      end
    end

    private

      def user_game_params
        params.permit(:game_id, :cover_url, :name)
      end

  end
