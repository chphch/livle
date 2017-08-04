Rails.application.routes.draw do
  root 'feeds#index'

  get 'admin/feed'
  get 'admin/curation'
  get 'admin/artist'
  get 'admin/upcoming'
  get 'admin/connect'
  get 'admin/user_list'
  get 'admin/data'
  get 'admin/notice'
  get 'admin/index'

  get 'search/index'
  post 'search/search'

  resources :artists, only: [:index, :create, :show]
  post 'artists/:id/update' => 'artists#update'
  get 'artists/:id/destroy' => 'artists#destroy'

  resources :curations, only: [:create, :show] do
    resources :curation_comments, only: [:create, :update, :destroy]
    get 'create_like'
  end
  get 'curations/:id/update' => 'curations#update'
  get 'curations/:id/destroy' => 'curations#destroy'

  resources :feeds, only: [:index, :create, :show] do
    resources :feed_comments, only: [:create, :update, :destroy]
    get 'create_like'
  end
  get 'feeds/:id/update' => 'feeds#update'
  get 'feeds/:id/destroy' => 'feeds#destroy'

  resources :upcomings, only: [:index, :create, :show] do
    resources :upcoming_comments, only: [:create, :update, :destroy]
    get 'create_like'
  end
  get 'upcomings/:id/update' => 'upcomings#update'
  get 'upcomings/:id/destroy' => 'upcomings#destroy'

  get 'mypage/index'
  get 'mypage/edit_password'
  patch 'mypage/update_password'
  get 'mypage/edit_profile'
  get 'mypage/settings'
  get 'mypage/terms_of_use'
  get 'mypage/privacy_policy'
  post 'mypage/update_profile'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  resources :connect_urls, only: [:index, :new, :create, :destroy]
  resources :recent_keywords, only: [:create, :destroy]
  resources :notices, only: [:index, :create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
