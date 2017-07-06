Rails.application.routes.draw do
  root 'feeds#index'

  resources :upcoming_likes
  resources :recent_keywords
  get 'connect/index'

  get 'search/index'
  get 'search/search'

  resources :recommended_urls

  resources :curations do
    resources :curation_video
    resources :curation_like
    resources :curation_comment
  end

  resources :artists

  get 'feeds/:feed_id/watch' => 'feeds#watch'
  resources :feeds do
    resources :feed_artist
    resources :feed_like
    resources :feed_comment
  end

  get 'upcomings/:upcoming_id/watch' => 'upcomings#watch'
  resources :upcomings do
    resources :upcoming_comment
    resources :upcoming_artist
  end

  devise_for :users
  resources :users do
    resources :recommended_url
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
