Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  root to: 'tops#index'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :users, only: %i[new create show edit update]
  resources :posts do
    resources :comments, only: %i[create destroy], shallow: true
    collection do
      get :bookmarks
    end  
  end
  resources :bookmarks, only: %i[create destroy]
  resources :comment_bookmarks, only: %i[create destroy]
  resources :password_resets, only: %i[new create edit update]
end
