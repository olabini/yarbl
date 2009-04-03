ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.

  map.root :controller => "blogs", :action => "start"
  map.blogs 'blogs', :controller => "blogs", :action => "index"
  map.create_blog 'blogs/create', :controller => "blogs", :action => "create"
  map.remove_blog 'blogs/remove/:id', :controller => "blogs", :action => "remove"
  map.new_post 'blog/:id/new', :controller => "blogs", :action => "new_post"
  map.create_post 'blog/:id/create', :controller => "blogs", :action => "create_post"
  map.blog 'blog/:id', :controller => "blogs", :action => "blog"
  map.post 'blog/:blog_id/:post_id', :controller => "blogs", :action => "post"
  map.remove_post 'post/:id/remove', :controller => "blogs", :action => "remove_post"
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
