Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  resources :posts do
    post "/like", to: "likes#like_trigger"
    resources :comments, only: [:create, :destroy]
    get '/mypage', to: 'posts#show'
  end
  resources :follows, only: [:create, :destroy]
  
  
  # post "/mypage" => 'posts#mypage'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
