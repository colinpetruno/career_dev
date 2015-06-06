require "resque_web"

Rails.application.routes.draw do

  root "welcome#index"

  resources :companies, only: [:edit, :update] do
    resources :bank_accounts, only: [:new, :create] do
      resource :verification
    end
    resource :billing_plan, path: "billing"
    resources :categories
    resources :credit_cards, only: [:new, :create]
    resources :users, only: [:index, :edit, :show, :update], path: "employees" do
      resources :tasks, only: [:index], controller: 'users/tasks'
      resources :thank_yous, shallow: true
    end
    resources :funding_instruments, only: [:index], path: "payment-methods"
    resources :invitations, only: [:new, :create], path: "invitations"
    resources :settings, only: [:index]
    resources :subscriptions, only: [:update]
    resources :tasks do
      resources :offers, only: [:create, :update], shallow: true do
        resources :submissions, shallow: true
      end
    end
  end

  resources :tasks do
    resources :offers, only: [:create, :update]
  end

  resources :registrations, only: [:new, :create]

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  mount Attachinary::Engine => "/attachinary"

  # TODO: Restrict access for site admins
  ResqueWeb::Engine.eager_load!
  mount ResqueWeb::Engine => "/resque_web"

end
