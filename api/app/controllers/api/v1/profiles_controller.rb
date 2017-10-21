class Api::V1::ProfilesController < ApplicationController
  before_action :authenticate_user?

    def index
      @profiles = Profile.all
      render json: @profiles, each_serializer: ProfileSerializer
    end

    def show
      if @profile = Profile.where(["user_id = ?", @user.id]).first
        render json: @profile, serializer: ProfileSerializer
      else
        render json: {
          error: "Profile Not Found",
          status: 400
        }, status: 400
      end
    end

    def create
      @user = get_current_user
      profile_save_params = profile_params
      profile_save_params[:user_id] = @user.id

      @profile = Profile.new(profile_save_params)
      if @profile.save
        render json: @profile, serializer: ProfileSerializer
      else
        render json: {
          error: "Profile failed to create",
          status: 400
        }, status: 400
      end
    end

    def update
      @profile = Profile.where(["user_id = ?", @user.id]).first
      if @profile.update(profile_params)
        render json: @profile, serializer: ProfileSerializer
      else
        render json: @profile.errors, status: 400
      end
    end

    def destroy
      @profile = Profile.find(params[:id])
      if @profile.destroy
        render json: { message: 'Profile was deleted successfully.' }
      else
        render json: @profile.errors, status: 400
      end
    end

    private

      def profile_params
        params.permit(:display_name, :first_name, :last_name)
      end

  end
