Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get 'games/search/:id', to: 'games#search'
      get 'games/search', to: 'games#default_list'
      get 'user_games/my_list', to: 'user_games#my_list'
      post 'user_games_toggle', to: 'user_games#toggle'
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
