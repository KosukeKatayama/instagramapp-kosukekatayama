Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'articles#index'

  resource :profile, only: %i[show edit update]

  resources :articles, only: %i[index new create] do
    resource :like, only: %i[show create destroy]
    resources :comments, only: %i[index new create]
  end
end
