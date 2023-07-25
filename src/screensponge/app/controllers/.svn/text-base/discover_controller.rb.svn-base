class DiscoverController < ApplicationController
  
  before_filter :login_required, :except=> [:index,:discover,:search,:browse]
  
  
  
  #
  # index/discover/search/browse are all the same, separated for user perception
  #
  
  def generic_init
    # must be options then query, for the search hack
    prepare_show_options
    @shows = buildShowFilterSortQuery(nil, params, true)
  end
  
  def index
    generic_init
  end
  
  def discover
    generic_init
    render :action=>"index"
  end
  
  def search
    generic_init
    render :action=>"index"
  end
  
  def browse
    generic_init
    render :action=>"index"
  end




  # shows not in the user profile
  # does not include shows in profile not marked as seen
  def system_unseen    
    @shows = Show.paginate(:all, :page => params[:page], :group=>"global_id",:order=>"name ASC",
      :conditions=>["global_id not in (select global_id from shows where user_id=?)", current_user.id]) 
      
    @mode = "system_unseen"
    render :action=>"index"
  end
  
  def friends_unseen
    @shows = Show.paginate(:all, :page => params[:page], :group=>"global_id",:order=>"name ASC",
      :joins=>"INNER JOIN friendships ON friendships.friend_id=shows.user_id",
      :conditions=>["friendships.user_id=? and friendships.status=? and shows.global_id not in (select global_id from shows where user_id=? group by global_id)",
        current_user.id,Friendship::ACCEPTED, current_user.id])

    @mode = "friends_unseen"
    render :action=>"index"
  end
  
  # shows not in current user or current users friends profile
  def system_friends_unseen
    @shows = Show.paginate(:all, :page => params[:page], :group=>"global_id",:order=>"name ASC",
      :conditions=>["global_id not in (select global_id from shows where user_id=?) and " + 
        "global_id not in (select global_id from shows INNER JOIN friendships ON friendships.friend_id=shows.user_id " + 
        "where friendships.user_id=? and friendships.status=? group by global_id)", current_user.id,current_user.id,Friendship::ACCEPTED]) 

    @mode = "system_friends_unseen"
    render :action=>"index"
  end
  
end
