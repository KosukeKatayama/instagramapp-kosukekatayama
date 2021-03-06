require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'articles#index'

  resources :accounts, only: %i[show] do
    resources :followings, only: %i[index]
    resources :followers, only: %i[index]
    resources :follows, only: %i[create]
    resources :unfollows, only: %i[create]
  end

  resources :articles, only: %i[index new create] do
    resources :comments, only: %i[index new create]
  end

  scope module: :apps do
    resource :profile, only: %i[show edit update]
    resource :popular, only: %i[show]
  end

  namespace :api do
    scope '/articles/:article_id' do
      resources :comments, only: %i[index new create]
      resource :like, only: %i[show create destroy]
    end
  end
end
