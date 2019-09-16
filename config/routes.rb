Rails.application.routes.draw do
  root "welcome#index"
  get :most_dangerous_day, to: "most_dangerous_day#index"

  namespace :api do
    namespace :v1 do
      namespace :user do
        get "/favorites", to: "favorites#show"
        post "/favorites", to: "favorites#create"
      end
    end
  end
end
