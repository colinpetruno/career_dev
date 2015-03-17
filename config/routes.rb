require "resque_web"

Rails.application.routes.draw do

  root "welcome#index"

  resources :companies, only: [:edit, :update] do
    resources :bank_accounts, only: [:new, :create] do
      resource :verification
    end
    resource :billing_plan, path: "billing"
    resources :credit_cards, only: [:new, :create]
    resources :users, only: [:index, :edit, :update], path: "employees"
    resources :funding_instruments, only: [:index], path: "payment-methods"
    resources :settings, only: [:index]
    resources :subscriptions, only: [:update]
    resources :tasks do
      resources :offers, only: [:create, :update]
    end
  end

  resources :tasks do
    resources :offers, only: [:create, :update]
  end

  resources :registrations, only: [:new, :create]

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }


  # TODO: Restrict access for site admins
  mount ResqueWeb::Engine => "/resque_web"

end
