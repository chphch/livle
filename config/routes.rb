Rails.application.routes.draw do
  resources :artist_upcomings
  resources :comment_upcomings
  resources :comment_feeds
  resources :curations
  resources :artists
  resources :feeds
  resources :upcomings
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
