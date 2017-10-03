class Api::V1::UserGamesController < ApplicationController
  before_action :authenticate_user?
  
    def index
      @user_games = UserGame.all
      render json: @user_games, each_serializer: UserGameSerializer
    end
  
    def show
      @user_game = UserGame.find(params[:id])
      render json: @user_game, serializer: UserGameSerializer
    end
  
    def create
      @user = get_current_user
      user_game_save_params = user_game_params
      profile_save_params[:user_id] = @user.id

      @user_game = UserGame.new(user_game_save_params)
      if @user_game.save
        render json: @user_game, serializer: UserGameSerializer
      else
        render json: {
          error: "Game could not be added to User\'s list",
          status: 400
        }, status: 400
      end
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
        params.permit(:game_id)
      end
  
  end
  