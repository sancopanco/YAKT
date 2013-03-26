MtmKanban::Application.routes.draw do
  #match "home/index" => 'home#index', :via => :get, :as => :home
  authenticated :user do
    match 'dashboard' => 'user_dashboard#index', :as => 'user_root'
  end
  
  root :to => "home#index"
  match 'dashboard' => 'user_dashboard#index', :as => 'user_root'
  devise_for :users
  resources :users
  resources :tasks

  resources :boards do
    resources :states do
      resources :cards
    end
    resources :memberships
  end
  
  
  resources :boards
  resources :cards, :users do
    post :sort, :on => :collection
  end
  #resources :cards do  
  #  match "update_users" => 'cards#update_users', :via => :put, :as => :update_users
  #end
  #match "cards/update_positions" => 'work_items#update_positions', :via => :post, :as => :update_positions
  #match "states/update_positions" => 'statess#update_positions', :via => :post, :as => :update_states_positions

  resources :states
  resources :priorities
  resource :profile
  
  #For Ajax
  #match 'open_model_to_create_new_board' => 'user_dashboard#open_model_to_create_new_board'
  match 'add_task_to_card' => 'cards#add_task_to_card'
  match 'open_new_card_modal' => 'cards#open_new_card_modal'
  
  
 
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end


  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
