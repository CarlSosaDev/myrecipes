Rails.application.routes.draw do
  root "pages#home"
  get 'pages/home', to: 'pages#home'
  get '/signup', to:'chefs#new'

   get '/login', to:'sessions#new'
   post '/login', to: 'sessions#create'
   delete '/logout', to:"sessions#destroy"

   resources :chefs, except: [:new]
   resources :recipes do
     resources :comments, only: [:create]
   end
  resources :ingredients, except: [:destroy]
  mount ActionCable.server => '/cable';

end
