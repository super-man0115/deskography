Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  root to: 'static_pages#index'
  get 'privacy', to: 'static_pages#privacy'
  get 'terms', to: 'static_pages#terms'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  post "guest_login", to: "user_sessions#guest_login"
  resources :users, only: %i[new create show edit update]
  resources :posts do
    resources :comments, only: %i[create destroy update], shallow: true
    collection do
      get :bookmarks
    end
  end
  post 'posts/upload_image', to: 'posts#upload_image'
  resources :bookmarks, only: %i[create destroy]
  resources :comment_bookmarks, only: %i[create destroy]
  resources :password_resets, only: %i[new create edit update]
  resources :items, only: %i[index create destroy]
  get 'search', to: 'items#search'
  post "oauth/callback", to: "oauths#callback"
  get "oauth/callback", to: "oauths#callback"
  get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider
end
