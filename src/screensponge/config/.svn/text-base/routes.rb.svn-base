ActionController::Routing::Routes.draw do |map|


  #
  # help: http://api.rubyonrails.org/classes/ActionController/Resources.html
  #

  # authentication management
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.activate '/activate/:id', :controller => 'accounts', :action => 'show'
  map.forgot_password '/forgot_password', :controller => 'passwords', :action => 'new'
  map.reset_password '/reset_password/:id', :controller => 'passwords', :action => 'edit'
  map.change_password '/change_password', :controller => 'accounts', :action => 'edit'
  map.open_id_complete 'session', :controller => "sessions", :action => "create", :requirements => { :method => :get }

  map.resource :session
  map.resource :password
  map.resources :activities
  
  
  #map.search '/search', :controller => 'shows', :action => 'search'
  # map.related '/related.:format', :controller => 'shows', :action => 'related'
  
  # finding friends
  # map.find_friends 'friends/find', :controller => 'friends', :action => 'find'
  # map.search_friend 'friends/search', :controller => 'friends', :action => 'find'
  
  map.discover 'discover', :controller=>"discover", :action=>"discover"
  map.show_search 'search', :controller=>"discover", :action=>"search"
  map.show_browse 'browse', :controller=>"discover", :action=>"browse"
  
  # nav
  map.nav_home 'home', :controller=>"home", :action=>"index"
  map.nav_me 'me', :controller=>"users", :action=>"nav_me"
  map.nav_friends 'friends', :controller=>"friends", :action=>"index"
  map.nav_shows 'shows', :controller=>"shows", :action=>"index"
  map.nav_discover 'discover', :controller=>"discover", :action=>"browse"
  
  
  # users
  map.resources :users, :as => "u", :member => {:enable=>:put} do |users|
    users.resource :account
    users.resources :roles
    # friend resources
    users.resources :friends, :collection=>{:filter=>:get, :manage=>:get, :find=>:get, :invite=>:get}
    users.resources :activities
    # show resources
    users.resources :shows, 
      :member=>{:add=>:put,:intention=>:put,:possession=>:put,:want=>:put,:have=>:put,:clear=>:put,:quickadd=>:put,:members=>:get,:add_parent=>:any},
      :collection=>{:filter=>:get,:wanted_and_have=>:get} do |shows|
      shows.resources :annotations
      shows.resources :messages
      shows.resources :reviews
      shows.resources :plots
      shows.resources :pictures
      shows.resources :intentions, :member=>{:toggle=>:get}
      shows.resources :types
      shows.resources :covers
      shows.resources :links
      shows.resources :videos
      shows.resources :activities
      shows.resources :possessions
      shows.resource :ratings, :member=>{:update=>:post}
      shows.resources :events
      shows.resources :requests, :member=>{:close=>:put}
    end
  end
  
  # home things, generally static pages
  map.with_options :controller => 'home' do |home|
    home.home 'home', :action => 'index'
    home.about 'about', :action => 'about'
    home.feedback 'feedback', :action => 'feedback'
    home.terms 'terms', :action => 'terms'
    home.privacy 'privacy', :action => 'privacy'
    home.help 'help', :action => 'help'
  end
  
    # sitemap route
  map.connect "sitemap.xml", :controller => "sitemap", :action => "sitemap"
  
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
  map.root :controller => "home"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
