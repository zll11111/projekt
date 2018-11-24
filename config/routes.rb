Rails.application.routes.draw do

  get 'upload/upload_image'
  resources :projects do
    collection do
      get 'current_user', to:'projects#have_user', as:'current_user'
    end
  end
  resources :teams

  get 'home/index'
  devise_for :users, controllers:{registrations: 'registrations',confirmations: 'confirmations'}
  #devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
  root to: "home#index"

  devise_scope :user do
    match 'user/confirmation', to: 'confirmations#update', via: [:put,:patch], as: :update_user_confirmation
  end

  resources :users do
    resources :teams,only:[]  do
      collection do
        get 'index',to:'teams#have_user'
      end
    end
  end

  post '/upload_image', to: 'upload#upload_image'

  post '/upload_file', to: 'upload#upload_file'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
