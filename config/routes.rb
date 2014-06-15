Rails.application.routes.draw do
  resources :users do
    collection do
    end
  end
  resources :clock do
    collection do
    end
  end
end
