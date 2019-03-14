Rails.application.routes.draw do
  get '/areas', to: 'areas#index'
  post '/areas/search', to: 'areas#form'
  post '/areas', to: 'areas#create'
  get '/areas/search', to: 'areas#search'
end
