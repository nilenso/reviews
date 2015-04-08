Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: "reviews#index"

  resources :reviews do
    resources :comments, controller: :review_comments
    collection do
      delete :destroy
    end
  end

  resources :users do
    resources :reviews, controller: "users/reviews"
  end
end
