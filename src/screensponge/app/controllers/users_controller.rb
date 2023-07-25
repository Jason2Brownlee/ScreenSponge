class UsersController < ApplicationController

  before_filter :not_logged_in_required, :only => [:new, :create] 
  before_filter :login_required, :only => [:edit, :show, :update, :nav_me]
  before_filter :check_administrator_role, :only => [:index, :destroy, :enable]

  def nav_me
    redirect_to current_user 
  end

  def change_email_notification
    @user = current_user
    if request.post?
      @user = current_user
      notify_enabled = params[:user][:notification_enabled]
      if @user.update_attribute(:notification_enabled, notify_enabled)
        flash[:notice] = "Email notification updated"
        redirect_to :action => 'show', :id => current_user
      else
        render :action => 'change_email_notification'
      end 
    else 
      @user = current_user
    end
  end 

  def index
    if params[:premium] == "true"
      @users = User.paginate :all, :conditions=>["roles.rolename=?","subscribed"], :include=>:roles, :page => params[:page]
    else
      @users = User.paginate :all, :page => params[:page]
    end
  end
  

  # me
  def show    
    # hack for old code
    load_user
    if !@is_self
      redirect_to user_shows_path(@user)
      return
    end
    
    # all requests made by this user
    @requested = Request.user_has_requested(current_user)
    # requests against the user
    @pending_requests = Request.requested_against_user(current_user)
    # wanted shows friends have
    @wanted_shows_friends_have = current_user.wanted_shows_that_friends_have
    # radar of shows user may be interested in
    @interesting_shows = current_user.shows_radar
  end

  # render new.rhtml
  def new
    @user = User.new
  end

  def create
    # check T&C selected
    params[:user]

    cookies.delete :auth_token
    @user = User.new(params[:user])
    @user.save!
    #Uncomment to have the user logged in after creating an account - Not Recommended
    #self.current_user = @user

    flash[:notice] = "Thanks for signing up! Please check your email to activate your account before logging in."
    redirect_to login_path    
  rescue ActiveRecord::RecordInvalid
    flash[:error] = "There was a problem creating your account."
    render :action => 'new'
  end

  def edit
    @user = current_user
  end

  
  def update
    @user = User.find(current_user.id)
    # update all parameters changed
    if @user.update_attributes(params[:user])
      flash[:notice] = "User updated"
      redirect_to :action => 'show', :id => current_user.permalink
    else
      render :action => 'edit'
    end
  end

  def destroy
    load_user
    if @user.update_attribute(:enabled, false)
      flash[:notice] = "User disabled"
    else
      flash[:error] = "There was a problem disabling this user."
    end
    redirect_to :action => 'index'
  end

  def enable
    load_user
    if @user.update_attribute(:enabled, true)
      flash[:notice] = "User enabled"
    else
      flash[:error] = "There was a problem enabling this user."
    end
    redirect_to :action => 'index'
  end

end
