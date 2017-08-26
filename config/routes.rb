Rails.application.routes.draw do
  root 'feeds#index'

  get 'admin/feed'
  get 'admin/artist'
  get 'admin/upcoming'
  get 'admin/connect'
  get 'admin/user_list'
  get 'admin/data'
  get 'admin/notice'
  get 'admin/index'

  get 'search' => 'search#index'
  get 'search/result'


  resources :artists, only: [:index, :create, :show, :update, :destroy]

  resources :feeds do
    resources :feed_comments, only: [:create, :update, :destroy]
    get 'toggle_like'
  end
  get 'feeds/toggle_like/:player_id' => 'feeds#toggle_like'

  resources :upcomings do
    resources :upcoming_comments, only: [:create, :update, :destroy]
    get 'toggle_like'
  end

  get 'mypage/index'
  get 'mypage/edit_profile'
  patch 'mypage/update_profile' => 'mypage#update_profile'
  get 'mypage/settings'
  get 'mypage/terms_of_use'
  get 'mypage/privacy_policy'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'users/passwords/after_create'
  end

  resources :connect_urls, only: [:index, :new, :create, :destroy]
  resources :recent_keywords, only: [:create, :destroy]
  resources :notices, only: [:index, :create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
