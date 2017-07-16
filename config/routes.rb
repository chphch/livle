Rails.application.routes.draw do
  root 'feeds#index'

  get 'search/index'
  post 'search/search'

  resources :artists

  resources :curations do
    resources :curation_likes, only: [:create] ## create method do either like or unlike
    resources :curation_comments, only: [:create, :update, :destroy]
  end

  resources :feeds do
    resources :feed_likes, only: [:create]
    resources :feed_comments, only: [:create, :update, :destroy]
  end

  resources :upcomings do
    resources :upcoming_likes, only: [:create]
    resources :upcoming_comments, only: [:create, :update, :destroy]
  end

  get 'mypage/index'
  get 'mypage/edit_profile'
  get 'mypage/settings'
  post 'mypage/update_profile'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  resources :connect_urls, only: [:index, :new, :create, :destroy]
  resources :recent_keywords, only: [:create, :destroy]
  resources :notices

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
