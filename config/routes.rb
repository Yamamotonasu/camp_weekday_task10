Rails.application.routes.draw do
  root 'areas#index'
  post '/areas/search', to: 'areas#form'
  post '/areas', to: 'areas#create'
  get '/areas/search', to: 'areas#search'
  # 空登録を2回繰り返した時のルーティングエラー防止
  get '/areas', to: 'areas#form'
end
