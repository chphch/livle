Rails.application.routes.draw do
  resources :upcoming_likes
  resources :recent_keywords
  get 'connect/index'

  get 'search/index'

  get 'search/search'

  root 'feeds#index'
  resources :recommended_urls

  resources :curations do
    resources :curation_video
    resources :curation_like
    resources :curation_comment
  end

  resources :artists

  get 'feeds/:id/watch' => 'feeds#watch'
  resources :feeds do
    resources :feed_artist
    resources :feed_like
    resources :feed_comment
  end

  get 'upcomings/:id/watch' => 'upcomings#watch'
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
