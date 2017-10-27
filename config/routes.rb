Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  namespace :api do
    namespace :v1 do
      post 'signup', to: 'users#create'
      post 'login', to: 'users#login'
      
      resources :users
      resources :profiles
      resources :games
      resources :user_games
      resources :teammates
    end
  end
end