Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :shows, only: [:index]
      resources :users, only: [] do
        collection do
          get 'shows', to: 'users#index'
        end
        resources :shows, only: [:index, :create, :destroy], controller: 'user_shows'
      end
    end
  end
end

# GET	/api/v1/shows	ShowsController
#index	Retrieves all festival shows.

# GET	/api/v1/users/shows	UsersController
#index	Retrieves all users and their schedules, including shows.

# GET	/api/v1/users/:user_id/shows	UserShowsController
#index	Retrieves all shows in a specific user's schedule.

# POST	/api/v1/users/:user_id/shows	UserShowsController
#create	Adds a specific show to a user's schedule.

# DELETE	/api/v1/users/:user_id/shows/:id	UserShowsController
#destroy	Removes a specific show from a user's schedule.