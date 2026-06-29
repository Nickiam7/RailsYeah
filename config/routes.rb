Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # SEO crawlability files (machine-facing; see SitemapsController / RobotsController).
  get "/sitemap.xml", to: "sitemaps#show", as: :sitemap, defaults: { format: "xml" }
  get "/robots.txt", to: "robots#show", as: :robots

  # Admin area — authenticated, admin-only (see Admin::BaseController + AdminPolicy).
  namespace :admin do
    root to: "dashboard#show"

    resource :hero_content, only: %i[edit update]
    resource :instructor, only: %i[edit update]
    resources :learning_objectives, except: %i[show]
    resources :curriculum_sections, except: %i[show]
    resources :testimonials, except: %i[show]
    resources :faq_items, except: %i[show]
  end

  # Defines the root path route ("/")
  root "pages#home"
end
