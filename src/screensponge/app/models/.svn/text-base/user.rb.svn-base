require 'digest/sha1'
class User < ActiveRecord::Base
  # Virtual attribute for the unencrypted password
  attr_accessor :password

  validates_presence_of     :login, :email
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_length_of       :login,    :within => 3..40
  validates_length_of       :email,    :within => 6..100
  validates_format_of       :email,
  :with => %r{\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z}i, 
  :message => "should be like xxx@yyy.zzz"
  validates_uniqueness_of   :login, :email, :case_sensitive => false
  
  # login must be chards and numbers, avoid hidden duplicates in permalinks 
  # when other chars are converted to '+'
  validates_format_of       :login,
  :with => /\A[a-z0-9]+\Z/i, 
  :message => "only numbers and letters"

  # permissions
  has_many :permissions, :dependent => :destroy
  has_many :roles, :through => :permissions
  has_many :activities, :dependent => :destroy
  has_many :friendships, :dependent => :destroy, :order=>"created_at DESC"
  has_many :shows, :dependent => :destroy, :order => "name ASC"
  has_many :subscriptions
  
  # virtual  
  has_many :friends, :through => :friendships, :conditions => "friendships.status='#{Friendship::ACCEPTED}'", :order => "friendships.created_at"
  has_many :requested_friends, :through => :friendships, :source => :friend, :conditions => "friendships.status = '#{Friendship::REQUESTED}'", :order => "friendships.created_at"
  has_many :pending_friends, :through => :friendships, :source => :friend, :conditions => "friendships.status = '#{Friendship::PENDING}'", :order => "friendships.created_at"

  # named scopes
  named_scope :enabled_users, :conditions => "enabled<>0", :order=>"login"

  # before saves
  before_save :encrypt_password
  before_save :make_permalink
  before_create :make_activation_code
  
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :password, :password_confirmation, :identity_url, :time_zone





  # to_param method is used by the named routes in restful rails
  def to_param
    self.permalink.to_s
  end 

  
  
  def friends_recent_shows(limit=5)
    return if self.friends.empty?
    friend_ids = self.friends.map { |i| i['id'] }
    Show.find(:all,
      :conditions=>["user_id in (#{friend_ids.join(',')})"],
      :group=>"global_id",
      :order=>"shows.created_at DESC",
      :limit=>limit)
  end
  
  def all_show_group_activity
    show_gids = self.shows.map { |i| "'"+ i['global_id']+"'" }
    return Activity.find(:all, :limit=>20, :order=>"activities.created_at DESC",
      :conditions=>"shows.global_id in (#{show_gids.join(',')})", 
      :include=>:show)
  end
  
  # search users logins
  def self.search(query, page)
    paginate :per_page => 10, :page => page,
      :conditions => ['enabled<>0 and login like ?', "%#{query}%"],
      :order => 'login'
  end
  
  def update_last_signin_at
    self.last_signin_at = Time.now.utc
    save(false)
  end

  # shows with recent activity
  # TODO - the ordering is pox - wrong results
  def shows_with_recent_activity(limit=10)
    Show.find(:all,
    :joins=>"INNER JOIN activities on activities.show_id=shows.id",
    :conditions=>["shows.global_id in (select global_id from shows where user_id=?) and activities.type=? and activities.created_at>?", self.id, "AnnotationActivity", 1.day.ago],    
    :order=>"activities.created_at DESC",
# TODO - the group squashes the ordering we want - the shows with recent annotations
    :group=>"shows.global_id DESC",
    :limit=>limit)
  end

  # all of the shows recently added by friends
  # def friends_shows(page, limit=10)
  #    Show.paginate(:all, 
  #      :joins=>"INNER JOIN friendships ON friendships.friend_id=shows.user_id",
  #      :conditions=>["friendships.user_id=? and friendships.status=?",self.id,Friendship::ACCEPTED],
  #      :order=>"shows.created_at DESC",
  #      :per_page=>(limit.nil? ? Show.per_page : limit),
  #      :page=>page)
  #  end
  # 
  # all of the shows recently wanted by friends
   # def friends_wanted_shows(page, limit=10)
   #   Show.paginate(:all, 
   #     :joins=>"INNER JOIN friendships ON friendships.friend_id=shows.user_id",
   #     :conditions=>["friendships.user_id=? and friendships.status=? and shows.possession=?",self.id,Friendship::ACCEPTED,Show::Possession_want],
   #     :order=>"shows.created_at DESC",
   #     :per_page=>(limit.nil? ? Show.per_page : limit),
   #     :page=>page)
   # end
   # def count_friends_wanted_shows
   #   Show.count(:all, 
   #     :joins=>"INNER JOIN friendships ON friendships.friend_id=shows.user_id",
   #     :conditions=>["friendships.user_id=? and friendships.status=? and shows.possession=?",self.id,Friendship::ACCEPTED,Show::Possession_want])
   # end
   
   # all of the recently wantd shows by friends that this user has
   def friends_wanted_shows_user_has(page, limit=10)
     Show.paginate(:all, 
       :joins=>"INNER JOIN friendships ON friendships.friend_id=shows.user_id",
       :conditions=>["friendships.user_id=? AND friendships.status=? AND shows.possession=? AND " +
        "shows.global_id in (select shows.global_id from shows where user_id=? AND shows.possession=?)", 
        self.id,Friendship::ACCEPTED,Show::Possession_want,self.id,Show::Possession_have],
       :group=>"shows.global_id",
       :order=>"shows.created_at DESC",
       :per_page=>(limit.nil? ? Show.per_page : limit),
       :page=>page)
   end
   # def count_friends_wanted_shows_user_has
   #   rs = Show.count(:select=>"distinct shows.global_id",
   #     :joins=>"INNER JOIN friendships ON friendships.friend_id=shows.user_id",
   #     :conditions=>["friendships.user_id=? AND friendships.status=? AND shows.possession=? AND " +
   #      "shows.global_id in (select shows.global_id from shows where user_id=? AND shows.possession=?)", 
   #      self.id,Friendship::ACCEPTED,Show::Possession_want,self.id,Show::Possession_have])
   # end
  
  # all user friends (users) with a given show (global id)
  def friends_have_show(show, limit=5)
    return friends_show_possession(show, limit, Show::Possession_have)
  end
  def friends_want_show(show, limit=5)
    return friends_show_possession(show, limit, Show::Possession_want)
  end
  def friends_seen_show(show, limit=5)
    friends.find(:all, 
      :joins=>"INNER JOIN shows ON shows.user_id=friendships.friend_id",
      :conditions=>["shows.global_id=? and shows.intention=?",show.global_id, Show::Intention_seen],
      :order=>"shows.created_at DESC",
      :limit=>limit)
  end
  def friends_show_possession(show, limit, pos)
    friends.find(:all, 
      :joins=>"INNER JOIN shows ON shows.user_id=friendships.friend_id",
      :conditions=>["shows.global_id=? and shows.possession=?",show.global_id, pos],
      :order=>"shows.created_at DESC",
      :limit=>limit)
  end
  
  def shows_radar(limit=5, order="RAND()")
    # awesome discovery query
    # all shows this user doesn't have that have a parent that has the same global id as a show this user has
    # selects children shows for parent shows this user has 
    @interesting_shows = Show.find(:all,
    :joins=>"INNER JOIN shows as parents on parents.id = shows.parent_id",
    :conditions=>["parents.global_id in (select global_id from shows ss where ss.user_id=?) and " +
      "shows.global_id not in (select global_id from shows ss where ss.user_id=?)", self.id, self.id],
    :group=>"shows.global_id",
    :order=>order,
    :limit=>limit)
  end
  
  # listing of all wanted shows for user, that their friends have
  def wanted_shows_that_friends_have
    return if self.friends.empty?
    friend_ids = self.friends.map { |i| i['id'] }
    # deadly (group naturally because multimple friends could have the stuff user wants)
    Show.find(:all,
    :joins=>"LEFT OUTER JOIN shows as friends_shows on friends_shows.global_id=shows.global_id",
    :conditions=>["shows.user_id=? AND shows.possession=? AND friends_shows.user_id IN (#{friend_ids.join(',')}) AND friends_shows.possession=?", 
      self.id, Show::Possession_want, Show::Possession_have],
    :order=>"shows.created_at DESC",
    :group=>"shows.global_id")  
  end
  
  def count_friends_have_show(show)
    return count_friends_show_possession(show,  Show::Possession_have)
  end
  def count_friends_want_show(show)
    return count_friends_show_possession(show,  Show::Possession_want)
  end
  def count_friends_seen_show(show)
    friends.count(
      :joins=>"INNER JOIN shows ON shows.user_id=friendships.friend_id",
      :conditions=>["shows.global_id=? and shows.intention=?",show.global_id, Show::Intention_seen])
  end
  def count_friends_show_possession(show, pos)
    friends.count(
      :joins=>"INNER JOIN shows ON shows.user_id=friendships.friend_id",
      :conditions=>["shows.global_id=? and shows.possession=?",show.global_id, pos])
  end
  
  # all user friends (users) that want a given show (global id)
  def friends_want_show(show, limit=5)
    friends.find(:all, 
      :joins=>"INNER JOIN shows ON shows.user_id=friendships.friend_id",
      :conditions=>["shows.global_id=? and shows.possession=?",show.global_id, Show::Possession_want],
      :order=>"shows.created_at DESC",
      :limit=>limit)
  end
  def count_friends_want_show(show)
    friends.count(
      :joins=>"INNER JOIN shows ON shows.user_id=friendships.friend_id",
      :conditions=>["shows.global_id=? and shows.possession=?",show.global_id, Show::Possession_want])
  end

  # human readable login name
  def humanized_name
     return self.login
  end
  
  # used before save to store the permalink
  def urlized_name
    "#{login.gsub(/[^a-z0-9]+/i, '+')}"
  end
  
  def self.find_notifiabled(days)
    find :all, :conditions => ['notification_enabled = 1 and enabled = 1 and activated_at not null
                                and date(coalesce( last_signin_at, created_at)) <= date_sub(now(), INTERVAL ? DAY)
                                and date(coalesce( last_notification_email_at, date_sub(curdate(), INTERVAL 30 DAY))) <= date_sub(now(), INTERVAL ? DAY)', days, days]
  end

  # Activates the user in the database.
  def activate
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    save(false)
  end

  # Finds the user with the corresponding activation code, activates their account and returns the user.
  #
  # Raises:
  #  +User::ActivationCodeNotFound+ if there is no user with the corresponding activation code
  #  +User::AlreadyActivated+ if the user with the corresponding activation code has already activated their account
  def self.find_and_activate!(activation_code)
    raise ArgumentError if activation_code.nil?
    user = find_by_activation_code(activation_code)
    raise ActivationCodeNotFound if !user
    raise AlreadyActivated.new(user) if user.active?
    user.send(:activate!)
    user
  end

  def active?
    # the existence of an activation code means they have not activated yet
    activation_code.nil?
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    u = find :first, :conditions => ['login = ? and activated_at IS NOT NULL', login] # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def self.email_authenticate(email, password)
    u = find :first, :conditions => ['email = ? and activated_at IS NOT NULL', email] # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    remember_me_for 4.weeks
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    self.remember_token_expires_at = time
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  def forgot_password
    @forgotten_password = true
    self.make_password_reset_code
  end

  def reset_password
    # First update the password_reset_code before setting the
    # reset_password flag to avoid duplicate email notifications.
    update_attribute(:password_reset_code, nil)
    @reset_password = true
  end  

  #used in user_observer
  def recently_forgot_password?
    @forgotten_password
  end

  def recently_reset_password?
    @reset_password
  end

  def self.find_for_forget(email)
    find :first, :conditions => ['email = ? and activated_at IS NOT NULL', email]
  end

  def has_role?(rolename)
    self.roles.find_by_rolename(rolename) ? true : false
  end

  def has_administrator_role?
    has_role?('administrator')
  end

  def has_subscribed_role?
    return has_role?('subscribed')
  end


  def self.count_subscribed_users
    return User.count(:all, :conditions=>["roles.rolename=?","subscribed"],:include=>:roles)
  end
  
  # def self.count_paid_subscribed_users
  #   return Subscription.count(:all)
  # end
  
  protected
  # before filter 
  def encrypt_password
    return if password.blank?
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
    self.crypted_password = encrypt(password)
  end
  
  def make_permalink
    return if login.blank?
    self.permalink = urlized_name
  end

  def password_required?
    not_openid? && (crypted_password.blank? || !password.blank?)
  end

  def not_openid?
    identity_url.blank?
  end

  def make_activation_code
    self.activation_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
  end

  def make_password_reset_code
    self.password_reset_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
  end

  def activate!
    @activated = true
    self.update_attribute(:activated_at, Time.now.utc)
  end

end
