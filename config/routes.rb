Rails.application.routes.draw do
  root "welcome#index"
  get :most_dangerous_day, to: "most_dangerous_day#index"

  namespace :api do
    namespace :v1 do
      namespace :user do
        get "/favorites", to: "favorites#show"
      end
    end
  end
end
