Rails.application.routes.draw do
  get 'admin/feed'
  get 'admin/curation'
  get 'admin/artist'
  get 'admin/upcoming'
  get 'admin/connect'
  get 'admin/user_list'
  get 'admin/data'
  get 'admin/notice'
  get 'admin/index'

  root 'feeds#index'

  get 'search/index'
  post 'search/search'

  resources :artists

  resources :curations, only: [:create, :show] do
    resources :curation_comments, only: [:create, :update, :destroy]
  end
  get 'curations/:id/update' => 'feeds#update'
  get 'curations/:id/destroy' => 'feeds#destroy'

  resources :feeds, only: [:index, :create, :show] do
    resources :feed_comments, only: [:create, :update, :destroy]
  end
  get 'feeds/:id/update' => 'feeds#update'
  get 'feeds/:id/destroy' => 'feeds#destroy'

  resources :upcomings, only: [:index, :create, :show] do
    resources :upcoming_comments, only: [:create, :update, :destroy]
  end
  get 'upcomings/:id/update' => 'upcomings#update'
  get 'upcomings/:id/destroy' => 'upcomings#destroy'

  get 'create_like/:type/:post_id' => 'application#create_like', as: 'create_like'

  get 'mypage/index'
  get 'mypage/edit_profile'
  get 'mypage/settings'
  get 'mypage/notice'
  post 'mypage/update_profile'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  resources :connect_urls, only: [:index, :new, :create, :destroy]
  resources :recent_keywords, only: [:create, :destroy]
  resources :notices

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
