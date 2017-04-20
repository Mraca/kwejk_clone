Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :photos do
    collection do
      get 'search'
    end
  	member do
  		get "like", to: "photos#upvote"
  		get "dislike", to: "photos#downvote"
  	end
  	resources :comments
  end

  root 'photos#index'

  get '/random', to: 'photos#random'
  get '/toprated', to: 'photos#toprated'
  # get '/search', to: 'photos#search'

end
