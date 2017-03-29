Rails.application.routes.draw do
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users do
    collection do
      get :profile
      put :edit_profile
    end
  end

  resources :topics do
    member do
      post :comments
    end
    collection do
      get :about
    end
  end
  root "topics#index"

end