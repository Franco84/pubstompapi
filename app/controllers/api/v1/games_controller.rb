class Api::V1::GamesController < ApplicationController
  before_action :authenticate_user?
  
    def index
      @games = Game.all
      render json: @games, each_serializer: GameSerializer
    end
  
    def show
      @game = Game.find(params[:id])
      render json: @game, serializer: GameSerializer
    end

  #WILL BE LOADED IN THRU TASKS/ JOBS  FUTURE: Maybe admins?
    # def create
    #   @game = Game.new(game_save_params)
    #   if @game.save
    #     render json: @game, serializer: GameSerializer
    #   else
    #     render json: {
    #       error: "Game failed to create",
    #       status: 400
    #     }, status: 400
    #   end
    # end
  
    # def update
    #   if @game.update(game_params)
    #     render json: @game, serializer: GameSerializer
    #   else
    #     render json: @game.errors, status: 400
    #   end
    # end
  
    # def destroy
    #   if @game.destroy
    #     render json: { message: 'Game was deleted successfully.' }
    #   else
    #     render json: @game.errors, status: 400
    #   end
    # end
  
    private
  
  end
  