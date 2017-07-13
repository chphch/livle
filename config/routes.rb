Rails.application.routes.draw do
  root 'feeds#index'

  get 'connect/index'
  get 'search/index'
  get 'search/search'

  resources :artists

  resources :curations do
    resources :curation_artists
    resources :curation_likes
    resources :curation_comments
  end

  resources :feeds do
    resources :feed_artists
    resources :feed_likes
    resources :feed_comments
  end

  resources :upcomings do
    resources :upcoming_comments
    resources :upcoming_likes
    resources :upcoming_artists
  end

  get 'mypage/index'
  get 'mypage/edit_profile'
  get 'mypage/settings'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  resources :connect_urls
  resources :recent_keywords

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
