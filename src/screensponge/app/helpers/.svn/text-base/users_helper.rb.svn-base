require 'avatar/view/action_view_support'
module UsersHelper
  include Avatar::View::ActionViewSupport
  
  
  def user_name_noun(user)
    return "you" if logged_in? and current_user==user
    return user.humanized_name
  end
  
  def user_name_possessive(user)
    return "your" if logged_in? and current_user==user
    return "#{user.humanized_name}'s"
  end
  

  def is_owner?(a_ownable)
    return false if !logged_in?
    return false if current_user != a_ownable.user
    return true
  end
  
  # def user_link(user)
  #   return "you" if is_current_user_account?(user)
  #   return link_to(user.humanized_name, profile_user_path(user))
  # end
  
  def can_add_friend?(a_user)
    return false if !logged_in?
    return false if current_user == a_user
    # todo - make one friends entity to check on the join
    return false if current_user.requested_friends.include?(a_user)
    return false if current_user.friends.include?(a_user)
    return false if current_user.pending_friends.include?(a_user)
    return true
  end
  
  def add_friend_link(a_user)
    return if !can_add_friend?(a_user)
    link_to 'Add friend', user_friends_path(:user_id=>current_user, :friend_id => a_user), :method => :post, :style=>"padding-left: 2em; background: url('/images/btn_add.gif') 10% 50% no-repeat;"
  end
  
  def u_link(a_user)
    link_to a_user.humanized_name, user_path(:id=>a_user.login)
  end
  
  def u_edit_link(a_user)
    link_to "Settings", edit_user_path(:id=>a_user.permalink)
  end
  
  def u_url(a_user)
    user_url(:id=>a_user.permalink)
  end
  
end