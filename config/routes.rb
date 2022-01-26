Rails.application.routes.draw do
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
  scope "(:locale)", locale: /en|fr|ar|ch|du|ge|in|it|ja|ko|pl|pt|rus|sp/ do
    root to: 'pages#home'
    get '/faq', to: 'pages#faq'
    devise_for :users
    namespace :admin do
      resources :countries, only: [:index, :new, :create, :edit, :update, :destroy]
      resources :posts, only: [:new, :create, :edit, :update, :destroy]
      resources :jobs, only: [:new, :create, :edit, :update, :destroy]
    end
    resources :posts, only: [:index, :show]
    resources :jobs, only: [:index, :show]
    post '/send_email', to: 'pages#send_email'
    post '/subscribe', to: 'pages#subscribe'
    post '/create_contact', to: 'pages#create_contact'
    get '/about', to: 'pages#about'
    get '/contact', to: 'pages#contact'
    get '/inks_and_consumables', to: 'pages#inks_and_consumables'
    get '/distributor', to: 'pages#distributor'
    get '/cost_of_ownership', to: 'pages#cost_of_ownership'
    get '/printers', to: 'pages#printers'
    get '/fxone_remote', to: 'pages#fxone_remote'
    get '/fxone_standard', to: 'pages#fxone_standard'
    get '/fxone_plus', to: 'pages#fxone_plus'
    get '/faq', to: 'pages#faq'
    get '/software', to: 'pages#software'
    get '/industry', to: 'pages#industry'
    get '/video', to: 'pages#video'
    get '/legal', to: 'pages#legal'
    get '/privacy_policy', to: 'pages#privacy_policy'
    get '/seen_cookie', to: 'pages#seen_cookie_message'
    get '/cookie_policy', to: 'pages#cookie_policy'
    get '/contact_coders', to: 'pages#contact_coders'
    get '/foenix_codaprint', to: 'pages#foenix_codaprint'
    get '/foenix_codamark', to: 'pages#foenix_codamark'
    get '/foenix_codapack', to: 'pages#foenix_codapack'
    get '/support', to: 'pages#support'
    get '/inkjet-printer-old', to: 'pages#home'
  end
end
