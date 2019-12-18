Rails.application.routes.draw do
  scope "(:locale)", locale: /en|fr/ do
    root to: 'pages#home'
    get '/faq', to: 'pages#faq'
    devise_for :users
    namespace :admin do
      resources :countries, only: [:index, :new, :create, :edit, :update, :destroy]
      resources :posts, only: [:new, :create, :edit, :update, :destroy]
      resources :jobs, only: [:new, :create, :edit, :update, :destroy]
    end
    resources :posts
    resources :jobs, only: [:index, :show]
    post '/send_email', to: 'pages#send_email'
    post '/subscribe', to: 'pages#subscribe'
    post '/create_contact', to: 'pages#create_contact'
    get '/about', to: 'pages#about'
    get '/contact', to: 'pages#contact'
    get '/inks_and_consumables', to: 'pages#inks_and_consumables'
    get '/distributor', to: 'pages#distributor'
    get '/cost_of_ownership', to: 'pages#cost_of_ownership'
    get '/fxone_remote', to: 'pages#fxone_remote'
    get '/fxone_standard', to: 'pages#fxone_standard'
    get '/fxone_plus', to: 'pages#fxone_plus'
    get '/faq', to: 'pages#faq'
    get '/software', to: 'pages#software'
    get '/privacy_policy', to: 'pages#privacy_policy'
    get '/seen_cookie', to: 'pages#seen_cookie_message'
  end
end
