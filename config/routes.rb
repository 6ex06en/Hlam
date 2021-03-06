SecondApp::Application.routes.draw do
  resources :users do
      resources :messages, only: [:create, :show, :destroy, :index]
      resource :options, only: [:update]
      get :private_message
    member do
      get :following, :followers, :feed
    end
  end

  resources :microposts do
    member do
      post :reply
    end
  end
  #get "users/new"
  root  'static_pages#home'
  match '/signup',  to: 'users#new',      via: 'get'
  get   'confirmation/:id' => 'users#end_of_registration', as: :confirm
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  resources :users
  resources :sessions, only: [:new, :create, :destroy, :edit]
  resources :microposts, only: [:create, :destroy, :show]
  resources :relationships, only: [:create, :destroy]
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/forgot', to: 'sessions#forgot',        via: 'get'
  match '/remind', to: 'sessions#remind',        via: 'post'
  match '/search', to: 'microposts#search',       via: 'get'
  match '/auth/vkontakte/callback' => 'sessions#vk', via: 'get'

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
