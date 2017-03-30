Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users do
    collection do
      get :profile
      put :edit_profile
      put :edit_my_comment
      delete :del_my_comment
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