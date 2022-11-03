Rails.application.routes.draw do
  resources :inventories
  resources :items
  resources :users
  get '/main/login'
  get '/main/user_item'
  get '/main/inventories'
  get '/shop/:id' => 'shop#show'
  get '/main/buy/:id' => 'main#buy'
  get '/main/edit_item/:id' => 'main#edit_item'
  post '/main/relay'
  post '/main/relay2/:id' => 'main#relay2'
  post '/main/relay3'
  get '/main/add_item' => 'main#add_item'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
