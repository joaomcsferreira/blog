Rails.application.routes.draw do
  devise_for :users
  
  scope '/admin' do
    resources :users
  end

  resources :articles
  resources :roles

  root to: 'articles#index'

end
