class ProfilesController < ApplicationController
  
    def index
      @profiles = Profile.all
      
      render json: @profiles
    end
  
    def show
      profile_id = params[:profile_id]
      @profile = Profile.find(profile_id)

      render json: @profile
    end
  
    def create
      @profile = Profile.new(profile_params)
  
      if @profile.save
        render json: { profile: @profile }
      else
        render json: {
          error: "Profile failed to create",
          status: 400
        }, status: 400
      end
    end
  
    def update
      if @profile.update(profile_params)
        render json: @profile
      else
        render json: @profile.errors, status: 400
      end
    end
  
    def destroy
      @profile.destroy
    end
  
    private
  
      def profile_params
        params.permit(:display_name, :first_name, :last_name)
      end
  
  end
  