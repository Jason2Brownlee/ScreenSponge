class FriendsController < ApplicationController
  # based on: http://railsforum.com/viewtopic.php?id=16760

  before_filter :login_required



  def find
    if !params[:search].nil?
      @users = User.search(params[:search], params[:page])
    else
      @users = User.enabled_users.paginate(:all, :page => params[:page])
    end
  end

  def manage
      load_user
  end

  def index
    # hack for nav
    if params[:user_id].nil?
      redirect_to user_friends_path(current_user)
    else
      load_user
      
      # hack for protection
      if !@is_self
        redirect_to user_shows_path(@user)
        return
      end
      
      
      @all_friends = @user.friends
      
      prepare_show_options
      @shows = buildShowFilterSortQuery(current_user, params, true, true)
      
      # active friends
      @friends_count =  @user.friends.count
      @active_friends = @user.friends.find(:all, :limit=>5, :order=>"last_signin_at DESC")
    end
  end
  
  def filter
    load_user
    
    # retrieve the shows
    prepare_show_options
    if !params[:filter].nil? and !params[:filter][:friend].nil?
      # specific user
      user = current_user.friends.find_by_login(params[:filter][:friend])
      @shows = buildShowFilterSortQuery(user, params, true, false)
    else
      # all friends
      @shows = buildShowFilterSortQuery(current_user, params, true, true)
    end
    
    
    # prep
    @friend_param = params[:filter][:friend] if !params[:filter].nil?
    @all_friends = @user.friends
    
    # active friends
    @friends_count =  @user.friends.count
    @active_friends = @user.friends.find(:all, :limit=>5, :order=>"last_signin_at DESC")
		
		render :action=>"index"
  end



  def show
    redirect_to user_path(params[:id])
  end

  def new
    @friendship1 = Friendship.new
    @friendship2 = Friendship.new
  end

  def create
    @user = User.find(current_user)
    @friend = find_user(params[:friend_id])
    params[:friendship1] = {:user_id => @user.id, :friend_id => @friend.id, :status => Friendship::REQUESTED}
    params[:friendship2] = {:user_id => @friend.id, :friend_id => @user.id, :status => Friendship::PENDING}
    @friendship1 = Friendship.create(params[:friendship1])
    @friendship2 = Friendship.create(params[:friendship2])
    if @friendship1.save && @friendship2.save
      redirect_to user_friends_path(current_user)
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(current_user)
    @friend = find_user(params[:id])
    params[:friendship1] = {:user_id => @user.id, :friend_id => @friend.id, :status => Friendship::ACCEPTED}
    params[:friendship2] = {:user_id => @friend.id, :friend_id => @user.id, :status => Friendship::ACCEPTED}
    @friendship1 = Friendship.find_by_user_id_and_friend_id(@user.id, @friend.id)
    @friendship2 = Friendship.find_by_user_id_and_friend_id(@friend.id, @user.id)
    if @friendship1.update_attributes(params[:friendship1]) && @friendship2.update_attributes(params[:friendship2])
      flash[:notice] = 'Friend sucessfully accepted!'
      FriendActivity.new_friend(@user, @friend)
      redirect_to user_friends_path(current_user)
    else
      redirect_to user_path(current_user)
    end
  end

  def destroy
    # involved users
    @user = find_user(params[:user_id])
    @friend = find_user(params[:id])
    # delete relationship
    @friendship1 = @user.friendships.find_by_friend_id(@friend.id).destroy
    @friendship2 = @friend.friendships.find_by_user_id(@friend.id).destroy
    
    redirect_to user_friends_path(:user_id => current_user)
  end
  
  
  # invite a friend to the application
  def invite    
    if request.post?
      @invite = Feedback.new(params['invite'])
      # validation
      if @invite.save
        begin
          UserMailer::deliver_invite_message(@invite, current_user)
          flash[:notice] = "Your friend has been invited to join Screen Sponge."          
          redirect_to user_friends_path(current_user)
         rescue
           flash[:notice] = "There was a problem sending the message"
           render :action => "invite"
        end
      else
        # display error messages
        render :action=>"invite"
      end
    else
      # entry 
      @invite = Feedback.new
    end
  end

end
