Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :members
  
  root "home#top"

  resources :members, only: [:show, :edit, :update] do
    get 'favorites', on: :member # この行をresources :membersブロック内に移動
  end

  namespace :admin do
    resources :members, only: [:index, :show, :edit, :update, :destroy]
    resources :reviews, only: [:index, :edit, :update, :destroy] # 明確に管理者が行うアクションを指定
    resources :products, only: [:index, :edit, :update, :destroy] # 明確に管理者が行うアクションを指定
    resources :tags, only: [:index, :edit, :update, :destroy] # 明確に管理者が行うアクションを指定
    resources :posts, only: [:index, :edit, :update, :destroy] # 明確に管理者が行うアクションを指定
    resources :comments, only: [:index, :edit, :update, :destroy]
  end

  resources :favorites, only: [:create] do
    delete :destroy, on: :member
  end

  resources :reviews, only: [:index, :new, :create, :edit, :update, :show] do
    delete :destroy, on: :member
  end
  
  resources :products, only: [:index, :show, :new, :edit] do
    resources :comments, only: [:create]
    resource :favorites, only: [:create, :destroy] # 単数形に変更しておくと、idがルーティングに含まれなくなります。
  end

  # TagsControllerに対するルーティング
  resources :tags, only: [:show]

  # PostsControllerに対するルーティング
  resources :posts do
    collection do
      get :drafts # 下書きの投稿一覧を表示するためのアクションが正しくスコープ内に配置される
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  post 'guest_sign_in', to: 'members#guest_sign_in'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # Defines the root path route ("/")
  # root "posts#index"
end