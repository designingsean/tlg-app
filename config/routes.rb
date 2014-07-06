Rails.application.routes.draw do
  resources :users do
    collection do
    end
  end
  resources :clock do
    collection do
      get 'in/:id', :action => :create, :as => :create
      get 'out/:id', :action => :update, :as => :update
      get 'delete/:id', :action => :destroy, :as => :destroy
      post ':id/edit', :action => :add_new, :as => :add_new
    end
  end
end
