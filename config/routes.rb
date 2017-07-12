Rails.application.routes.draw do
  root 'feeds#index'

  get 'connect/index'
  get 'search/index'
  get 'search/search'

  resources :artists

  get 'curations/:curation_id/watch' => 'curations#watch'
  resources :curations do
    resources :curation_videos
    resources :curation_likes
    resources :curation_comments
  end

  get 'feeds/:feed_id/watch' => 'feeds#watch'
  resources :feeds do
    resources :feed_artists
    resources :feed_likes
    resources :feed_comments
  end

  get 'upcomings/:upcoming_id/watch' => 'upcomings#watch'
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

  resources :recent_keywords
  resources :recommended_urls

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
