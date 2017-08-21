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

  get 'search' => 'search#index'
  get 'search/result'

  resources :artists, only: [:index, :create, :show]

  resources :curations, only: [:create, :show] do
    resources :curation_comments, only: [:create, :update, :destroy]
    get 'toggle_like/' => 'curations#toggle_like'
    get 'toggle_like/:video_index' => 'curations#toggle_like'
  end

  resources :feeds do
    resources :feed_comments, only: [:create, :update, :destroy]
    get 'toggle_like' => 'feeds#toggle_like'
    get 'toggle_like/:video_index' => 'feeds#toggle_like'
  end

  resources :upcomings, only: [:index, :create, :show] do
    resources :upcoming_comments, only: [:create, :update, :destroy]
    get 'toggle_like'
  end
  get 'upcomings/toggle_video_like/:post_class/:post_id/:video_index' => 'upcomings#toggle_video_like'

  get 'mypage/index'
  get 'mypage/edit_profile'
  get 'mypage/update_profile'
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
  devise_scope :user do
    get 'users/passwords/after_create'
  end

  resources :connect_urls, only: [:index, :new, :create, :destroy]
  resources :recent_keywords, only: [:create, :destroy]
  resources :notices, only: [:index, :create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
