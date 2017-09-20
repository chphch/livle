Rails.application.routes.draw do
  root 'feeds#index'

  # Admin page
  get 'admin/feed', as: :admin_feed
  get 'admin/artist', as: :admin_artist
  get 'admin/upcoming', as: :admin_upcoming
  get 'admin/temporary_upcoming', as: :admin_temporary_upcoming
  get 'admin/connect', as: :admin_connect
  get 'admin/user_list', as: :admin_user_list
  get 'admin/data', as: :admin_data
  get 'admin/notice', as: :admin_notice
  get 'admin/index', as: :admin_index

  get 'search' => 'search#index'
  get 'search/result'
  get 'search/autocomplete'
  get 'search/clear_history'

  get 'artists/autocomplete'

  resources :artists, only: [:index, :create, :show, :update, :destroy]

  resources :feeds do
    resources :feed_comments, only: [:create, :update, :destroy], shallow: true
    resources :feed_artists, only: [:create, :destroy], shallow: true
    get 'toggle_like'
  end
  get 'feeds/toggle_like/:player_id' => 'feeds#toggle_like'
  post 'feeds/:id/share' => 'feeds#share'

  resources :upcomings do
    resources :upcoming_comments, only: [:create, :update, :destroy], shallow: true
    resources :upcoming_artists, only: [:create, :destroy], shallow: true
    get 'toggle_like'
  end

  resources :temporary_upcomings, only: [:update, :destroy]
  post 'temporary_upcomings/:id/merge' => 'temporary_upcomings#merge'

  get 'mypage/index'
  get 'mypage/about'
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
    # get 'users/auth/facebook/:remote_new_session' => 'users/omniauth_callbacks#facebook', as: :user_facebook_login_callback
    get 'users/passwords/after_create'
  end

  resources :connect_urls, only: [:index, :new, :create, :destroy]
  resources :recent_keywords, only: [:create, :destroy]
  resources :notices, only: [:index, :create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
