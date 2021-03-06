Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'registration' }
  root to: "home#index"
  namespace :admin do
    resources :barber
    resources :schedule, only: [:index, :new, :create]
      get 'schedule/gcal_redirect'
      get 'schedule/cutz_callback'
      get 'schedule/new_calendar'
      get 'schedule/add_appointment'
      get 'schedule/cancel_appointment'
      get 'schedule/get_calendar_id'
      get 'schedule/get_list'
  end

  resources :barber do
      resources :galleries, except: [:new, :create]
      resources :appointments, only: [:index ,:new, :create] do
        get 'appointments/welcome'
      end
      post 'referrals/question'
  end
  # resources :subscribers

  get "/auth/:provider/callback", to: "auth#callback"
  resources :calendar

  get 'galleries/new'
  post 'galleries/create'

  post 'barber/find'



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
