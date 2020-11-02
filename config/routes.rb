Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :drivers, only: [] do
        collection do
          post :register
        end
        member do
          post :send_location
        end
      end
      resources :passengers, only: [] do
        collection do
          post :available_cabs
        end
      end
    end
  end
end
