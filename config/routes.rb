HdataServer::Application.routes.draw do
  

  get "audit_review/index"

  get "audit_review/show"

  match '/auth/:provider/callback' => 'authentications#create'
  devise_for :users, :controllers => {:registrations => 'registrations'}
  
  resources :authentications

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
  match "audit_logs" => "audit_logs#index", :as => "audit_logs"

  resources :records do
    resources :c32
  end

  #
  match "records/:id" => "records#show", :as => "root_feed", :format => :atom
  match "records/:id/root.xml" => "records#root", :as => :root_document, :format => :xml
  match "records/:record_id/:section" => "entries#index", :as => :section_feed, :format => :atom, :method => :get
  match "records/:record_id/:section/:id" => "entries#show", :as => :section_document, :method => :get
  match "records/:record_id/:section" => "entries#create", :as => :new_section_document, :method => :post
  match "records/:record_id/:section/:id" => "entries#update", :as => :update_section_document, :method => :put

  root :to =>  "records#index"
  
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
   match ':controller(/:action(/:id(.:format)))'

end
