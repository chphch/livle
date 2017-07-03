Rails.application.routes.draw do
  resources :upcoming_artists
  resources :upcoming_comments
  resources :feed_comments
  resources :feed_likes
  resources :feed_artists
  resources :curation_comments
  resources :curation_likes
  resources :curation_videos
  root 'feeds#index'
  resources :recommended_urls
  resources :curations
  resources :artists
  resources :feeds
  resources :feeds do
  end
  resources :upcomings
  resources :upcomings do
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
