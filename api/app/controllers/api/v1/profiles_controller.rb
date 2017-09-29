class Api::V1::ProfilesController < ApplicationController
  
    def index
      @profiles = Profile.all

      render json: { profiles: @profiles }
    end
  
    def show
      profile_id = params[:profile_id]
      display_name = params[:display_name]

      @profile = Profile.find(profile_id)
      if !!@profile
        @profile = Profile.find_by({ display_name: display_name })
      end 

      render json: { profile: @profile }
    end
  
    def create
      @user = get_current_user
      puts "user"
      puts @user 
      if !!@user
        @profile = Profile.new(profile_params)
        
        if @profile.save
          @user.profile_id = @profile.id

          if @user.save
            render json: { profile: @profile }
          else 
            @profile.destroy
            render json: {
              error: "Profile could not be saved to user",
              status: 402
            }, status: 402
          end
        else
          render json: {
            error: "Profile failed to create",
            status: 400
          }, status: 400
        end
      else
        render json: {
          error: "Profile failed to create, must be logged in to create a profile",
          status: 402
        }, status: 402
      end  
    end
  
    def update
      if @profile.update(profile_params)
        render json: { profile: @profile }
      else
        render json: @profile.errors, status: 400
      end
    end
  
    def destroy
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
  