Rails.application.routes.draw do
  devise_for :users
  
  scope '/admin' do
    resources :users
  end

  resources :articles do
    resources :comments, only: %i[create destroy]  
  end
  resources :roles

  root to: 'articles#index'

end
