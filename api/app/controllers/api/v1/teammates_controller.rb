class Api::V1::TeammatesController < ApplicationController
  # before_action :authenticate_user?

  def show
    @user = User.find(params[:id])
    @teammates = @user.teammates
    render json: @teammates, each_serializer: UserSerializer
  end

  def create
    @user = current_user
    @teammate = find_user_by_params

    if !!@teammate
      @user.teammates << @teammate
      if @user.save
        render json: { message: "User was added as a teammate." }
      else 
        render json: {
          error: "User couldn't become a teammate",
          status: 400
        }, status: 400
      end 
    else
      render json: {
        error: "User couldn't become a teammate",
        status: 400
      }, status: 400
    end
  end

  def destroy
    @teammate = find_user_by_params
    @user_teammate = @user.teammates.where(:id => @teammate.id)

    if @user_teammate.destroy
      render json: { message: 'User is no longer a teammate.' }
    else
      render json: @user.errors, status: 400
    end
  end

  private

    def find_user_by_params
      teammate_id = params.permit(:user_id)
      teammate = User.find(teammate_id)
    end

end
