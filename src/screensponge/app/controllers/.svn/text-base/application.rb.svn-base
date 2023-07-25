# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.


class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  
  include AuthenticatedSystem
  
  # use users's time zone
  before_filter :set_time_zone

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '0897c5b08583dc087f71bdba3d649432'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password

  protected

  def view_show_flash_text(show)
    return "<a href=\"" + user_show_url(current_user, show) + "\">View '" + show.name + "'</a>"
  end
  
  def view_show_flash_link(show)
    return "<a href=\"" + user_show_url(current_user, show) + "\">'" + show.name + "'</a>"
  end
  
  
  private
  
  def load_user
    @user = find_user(params[:user_id])
    @is_self = (logged_in? and current_user==@user) ? true : false
  end
  
  def set_time_zone
    Time.zone = current_user.time_zone if logged_in?
  end
  
  def load_show 
    @show = Show.find(params[:show_id])
  end
  
  # locate the user in the url (may or not be self)
  # tries permalink first, then id
  def find_user(data=nil)
    data = params[:id] if data.nil?
    return User.find_by_permalink(data) || User.find(data)
  end
  
  def order_by
    return {} if params[:order].blank?
    direction = params[:direction] || "ASC"
        logger.info params[:order]
    #return { :order => "#{params[:order]} #{direction}" }
    return "#{params[:order]} #{direction}"
  end
  
  
  
  def prepare_show_options
    # states
    @all_show_states = Show::ShowStates.clone
		@all_show_states.insert(0,"All")
    # types
		@all_show_types = Show::TypeStates.clone
		@all_show_types.insert(0,"All")
		
		# always order
    if params[:sort].nil?
      params[:sort] = {:order=>"Recency"}
    end
		
		@state_param = (params[:filter].nil?) ? "All" : params[:filter][:state]
    @type_param = (params[:filter].nil?) ? "All" : params[:filter][:type]
    @order_param = (params[:sort].nil?) ? "Alphabetical" : params[:sort][:order]
        
    # total hack
    if params[:search_show].nil?
      if !params[:search].nil?
        @search_show = params[:search][:show]
        params[:search_show] = @search_show
      end
    else
      @search_show = params[:search_show]
    end
  end
  
  
  # deadly show finder
  def buildShowFilterSortQuery(user_owner, params, group_by=false, friends=false)    
    
    # user/friends
    if friends==true
      join_query = "INNER JOIN friendships ON friendships.friend_id=shows.user_id"
      friends_query = "friendships.user_id=#{user_owner.id} and friendships.status='#{Friendship::ACCEPTED}'"
    else      
      # a users shows
      if !user_owner.nil?
        user_query = "shows.user_id=#{user_owner.id}"
      end
    end
    
    # filter
     type_query = nil
     state_query = nil
    if !params[:filter].nil?      
      # show state
      state_param = params[:filter][:state]      
      if state_param=="Want"
        state_query = "shows.possession=#{Show::Possession_want}"      
      elsif state_param=="Have"
        state_query = "shows.possession=#{Show::Possession_have}"
      elsif state_param=="Seen"
        state_query = "shows.intention=#{Show::Intention_seen}"
      end
    
      # show type
      type_param = params[:filter][:type]     
      if Show::TypeStates.include?(type_param)
        type_query = "shows.show_type='#{type_param}'"
      end
    end
    
    # sort
    order_query = nil
    if !params[:sort].nil?
      # order
      order_param = params[:sort][:order]
      if order_param=="Recency"
        order_query = "shows.created_at DESC"
      elsif order_param=="Alphabetical"
        order_query = "shows.name ASC"
      # elsif order_param=="Popularity"
      #   order_query = "members_count DESC"
      end
    end
    
    # search
    search_param = params[:search_show]  
    #search_param.gsub!(/[^0-9A-Za-z.\-]/, '') 
    
    search_query = nil
    if !search_param.nil? and !search_param.blank?
      # TODO santize
      # search_param = ActionView::Helpers::SanitizeHelper.sanitize(search_param)
      search_query = "shows.name like '%#{search_param}%'"
    end
    
    # filter all child shows
    child_filter_query = " shows.parent_id is null "
    
    # group
    group_by_query = (group_by==true) ? "shows.global_id" : nil
    
    # build the query
    query = ""
    query = child_filter_query if (type_query.nil? and search_query.nil?)
    query += (query.blank?) ? user_query : " AND #{user_query}" if !user_query.nil?  
    query += (query.blank?) ? friends_query : " AND #{friends_query}" if !friends_query.nil?
    query += (query.blank?) ? state_query : " AND #{state_query}" if !state_query.nil?    
    query += (query.blank?) ? type_query : " AND #{type_query}" if !type_query.nil?
    query += (query.blank?) ? search_query : " AND #{search_query}" if !search_query.nil?
    
        
    # execute query
    return Show.paginate(:all,
      :page=>params[:page],
      :joins=>join_query,
      :conditions=>query,
      :group=>group_by_query,
      :order=>order_query)
  end

  
end
