Rails.application.routes.draw do
  resources :users do
    collection do
    end
  end
  resources :clock do
    collection do
      get 'in/:id', :action => :create, :as => :create
      get 'out/:id', :action => :update, :as => :update
    end
  end
end
