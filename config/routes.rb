Fotoverite::Application.routes.draw do

  match '/' => 'portfolios#index', :constraints => { :subdomain => 'portfolios' }
  match '/' => 'static_pages#show', :name => "projects", :constraints => { :subdomain => 'projects' }, :as => 'projects'
  match '/' => 'static_pages#show', :name => "log", :constraints => { :subdomain => 'log' }
  match '/' => 'static_pages#show', :name => "sites", :constraints => { :subdomain => 'sites' }
  match '/' => 'static_pages#show', :name => "testimonials", :constraints => { :subdomain => 'testimonials' }
  match '/' => 'static_pages#show', :name => "biography", :constraints => { :subdomain => 'bio' }
  root :to => 'static_pages#show', :name => "home"
  get "site/:name"  => 'static_pages#show', :as => "static_page"
  
  match 'portfolios/:id/page/(:page)' =>  'portfolios#show', :as => 'test'
  
  resources :portfolios, :only => [:show, :index], :constraints => { :subdomain => 'portfolios' } 

  namespace :staff do
    resource :access, :controller => "access", :except => [:edit, :update] do
      member do
        get :get_password_idea
      end
    end

    get 'edit-password/:token' => "access#edit_password", :as => 'edit_password'
    post 'reset_password/:token' => "access#reset_password", :as => 'reset_password'
    get "/" => "access#menu"
    get "menu" => "access#menu"
    get "/login" => "access#new"
    delete "/logout" => "access#destroy"
    get "forgot-password" => "access#forgot_password", :as => 'forgot_password'
    put "send-new-password" => "access#send_new_password", :as => 'send_new_password'
    post "send-token" => "access#send_token", :as => 'send_token'

    resources :users  do
      member do
        get :delete
      end
    end

    resources :portfolios  do
      member do
        get :delete
        get :photos
      end

      resources :photos, :only => [:edit, :update, :destroy] do
        collection do
          post :sort
        end
      end
    end

    resources :projects  do
      member do
        get :delete
      end
    end

  end

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
