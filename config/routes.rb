Rails.application.routes.draw do
  resources :review_years
  root to: "reviews#index"

  scope ':commentable_type' do
    resources :comments
  end

  resources :reviews do
    collection do
      delete :destroy
    end
  end

  resources :users do
    resources :reviews, controller: "users/reviews"
  end


  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
    get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end
end
