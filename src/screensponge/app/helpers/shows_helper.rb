module ShowsHelper
  
  def add_show_link(show)
    # return if user is not logged in 
    return if !logged_in?
    # only provide link if show isn't current users 
    return if logged_in? and show.user==current_user
    # or current user has the shows global id
    return if !current_user.shows.find(:first, :conditions=>["global_id=?",show.global_id]).nil?
    # prep the link
    link_to 'Add show', add_user_show_path(current_user, show), :method => :put, :style=>"padding-left: 2em; background: url('/images/btn_add.gif') 10% 50% no-repeat;"
  end
  
  def can_add_show?(show)
    # return if user is not logged in 
    return false if !logged_in?
    # only provide link if show isn't current users 
    return false if logged_in? and show.user==current_user
    # or current user has the shows global id
    return false if !current_user.shows.find(:first, :conditions=>["global_id=?",show.global_id]).nil?
    # prep the link
    return true;
  end
  
  def can_action_show?(show)
    # return if user is not logged in 
    return false if !logged_in?
    return true;
  end
  
  def delete_show_link(show, enabled=true)
    return if !enabled
    return if !logged_in? or show.user!=current_user
    link_to 'Delete', [current_user, show], :confirm => 'Are you sure?', :method => :delete
  end

  # def toggle_intention_link(show, enabled=true)
  #     intention = show.intentions.find(:first) if !show.intentions.empty?
  #     text = (intention.nil?) ? Intention::Unknown : intention.entry
  # 
  #     # only provide link if show isn't current users 
  #     return text if !enabled
  #     return text if !logged_in? or show.user!=current_user
  #     
  #     # prep link
  #     if intention.nil?
  #       link_to text, :controller=>"intentions", :action=>"toggle", :user_id=>current_user, :show_id=>show, :id=>nil
  #     else
  #       link_to text, :controller=>"intentions", :action=>"toggle", :user_id=>current_user, :show_id=>show, :id=>intention
  #     end
  #   end
  
  def show_name_parent_link(show)
    return if show.nil?
    
    link = link_to show.name, [show.user, show]
    return link if show.parent.nil?
    
    return show_name_parent_link(show.parent) + ':' + link 
  end
  
end
