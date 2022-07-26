Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "articles#index"

  #get '/articles', to: redirect('/articles/1')
  #get '/articles/:id', to: 'articles#show'

  resources :articles do 
    resources :comments, shallow: true
    get 'not_show', on: :member
  end

  resources :ads, as: 'periodical_ads'
  resources :videos, param: :identifier



  resources :audi do
    resources :bmw, shallow: true
  end

  resources :photos, controller: 'images', as: :vdd

  # scope :admin do
  #   resources :articles 
  # end
  #get '/articles', to: 'articles#index'


  #get '/articles', action: :index, controller: 'articles'
end
