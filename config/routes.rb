Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'
  # create all the routes for articles
  resources :articles
  get 'signup', to: 'users#new'
  # create routes for users, except :new, because :signup created above
  resources :users, except: [:new]
  # create routes for sessions
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  # create routes for categories
  resources :categories
end
