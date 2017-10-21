class Api::V1::UsersController < ApplicationController
  # before_action :authenticate_user?

  def index
    @users = User.all
    render json: @users, each_serializer: UserSerializer
  end

  def show
    @user = User.find(params[:id])
    render json: @user, serializer: UserSerializer
  end

  def create
    @user = User.new(user_params)

    if @user.save
      jwt = Auth.encrypt({ user_id: @user.id })
      render json: { token: jwt }
    else
      render json: {
        error: "User failed to create",
        status: 400
      }, status: 400
    end
  end

  def login
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      jwt = Auth.encrypt({ user_id: @user.id })
      render json: { token: jwt }
    else
      render json: {
        error: "Username or Password Incorrect"
      }
    end
  end

  def update
    if @user.update(user_params)
      render json: @user, serializer: UserSerializer
    else
      render json: @user.errors, status: 400
    end
  end

  def destroy
    if @user.destroy
      render json: { message: 'User was deleted successfully.' }
    else
      render json: @user.errors, status: 400
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.permit(:email, :password, :password_confirmation)
    end

end
