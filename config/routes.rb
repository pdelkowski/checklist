Rails.application.routes.draw do
  apipie
  
  namespace :api do
    namespace :v1 do

      resources :templates do
        resources :template_items, as: :items, path: 'items', only: [:index, :create]
      end
      resources :template_items, only: [:show, :update, :destroy]

      resources :checklists do
        resources :items, only: [:index, :create]
      end

      resources :items, only: [:update, :destroy] do
        member do
          post 'complete'
          post 'uncomplete'
        end
      end

    end
  end

  root 'default#homepage'
end
