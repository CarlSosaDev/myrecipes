Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root "pages#home"
  get 'pages/home', to: 'pages#home'
  get '/signup', to:'chefs#new'

   get '/login', to:'sessions#new'
   post '/login', to: 'sessions#create'
   delete '/logout', to:"sessions#destroy"

   resources :chefs, except: [:new]
   resources :recipes do
     resources :comments, only: [:create]
     member do
       post 'like'
     end
   end
  resources :ingredients, except: [:destroy]

   get '/chat', to:'chatrooms#show'

   resources :messages,only: [:create]
end
