Rails.application.routes.draw do
  devise_for :users
  get 'groups/:id' => 'games#group', as: "groups_show"

  patch 'groups/:id' => 'groups#update_name'

  delete 'groups/:id' => 'groups#destroy'

  delete 'groups/:id/leave' => 'groups#leave', as: "groups_leave"

  post 'groups' => 'groups#create'

  patch 'groups/:id/members' => 'groups#add_member', as: "groups_members"

  delete 'groups/:id/members/:username' => 'groups#remove_member', as: "groups_members_delete"

  post 'groups/:id/random' => 'games#random_game', as: "random_game"

  # root 'users#index'
  root 'games#home'

  # post 'users/new' => 'users#create'

  # patch 'users' => 'users#login'

  # delete 'users' => 'users#logout'

  post 'users/friend/new' => 'users#friend'

  patch 'users/friend/:id' => 'users#friend', as: "users_friend"

  delete 'users/friend/:id' => 'users#unfriend'

  get 'home' => 'games#home'

  # get 'users/edit'

  # patch 'users/edit' => 'users#update'

  get 'users/:id' => 'games#profile', as: 'users_profile'

  # post 'users/edit/pw' => 'users#pw_change'

  post 'games/search_games'

  post 'games/search_users'

  post 'games/:bgg_id' => 'games#rate', as: 'game'

  patch 'games/collection' => 'games#create'

  delete 'games/collection/:bgg_id' => 'games#delete', as: 'games_remove'

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
