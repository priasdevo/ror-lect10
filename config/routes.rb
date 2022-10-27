Rails.application.routes.draw do
  resources :inventories
  resources :items
  resources :users
  get '/main/login'
  get '/main/user_item'
  get '/main/inventories'
  get '/shop/:id' => 'shop#show'
  get '/main/buy/:id' => 'shop#show'
  post '/main/relay'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
