class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
    def get_current_user
      token = request.headers['HTTP_AUTHORIZATION']
  
      if token
        user_info = Auth.decode(token)
        @user ||= User.find(user_info['user_id'])
      end
  
      @user
    end

  end
end
