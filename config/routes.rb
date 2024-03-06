Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :members
  
  root "home#top"

  resources :members, only: [:show, :edit, :update] do
    get 'favorites', on: :member
    get 'products', on: :member, to: 'products#member_products', as: 'member_products'
    get 'posts', on: :member, to: 'posts#member_posts', as: 'member_posts'
    get 'reviews', on: :member, to: 'reviews#member_reviews', as: 'member_reviews'
    get 'comments', on: :member, to: 'comments#member_comments'
  end

  namespace :admin do
    resources :members, only: [:index, :show, :edit, :update, :destroy]
    resources :reviews, only: [:index, :edit, :update, :destroy]
    resources :products, only: [:index, :edit, :update, :destroy]
    resources :tags, only: [:index, :edit, :update, :destroy]
    resources :posts, only: [:index, :edit, :update, :destroy]
    resources :comments, only: [:index, :edit, :update, :destroy]
  end

  resources :favorites, only: [:create] do
    delete :destroy, on: :member
  end

  resources :reviews, only: [:index, :new, :create, :edit, :update, :show] do
    delete :destroy, on: :member
  end
  
  resources :comments, only: [:index, :destroy]
  
  resources :products, only: [:index, :show, :new, :edit, :create, :destroy] do
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    resources :posts, only: [:new, :create, :show, :index]
    resources :reviews, only: [:new, :create, :index] # レビューを製品にネストさせる
  end

  resources :tags, only: [:show]

  resources :posts do
    resources :comments, only: [:create]
    collection do
      get :drafts
    end
  end
  
  get "up" => "rails/health#show", as: :rails_health_check
  post 'guest_sign_in', to: 'members#guest_sign_in'
end