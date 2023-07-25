class Show < ActiveRecord::Base
  
  Possession_unknown = 0
  Possession_have = 1
  Possession_want = 2
  
  Intention_unknown = 0;
  Intention_seen = 1;
  Intention_unseen = 2;
  
  # used in the database
  Possession_states = [ Possession_unknown, Possession_have, Possession_want, nil]
  Intention_states = [ Intention_unknown, Intention_seen, Intention_unseen, nil]
  
  # used for search view
  ShowStates = ["Seen", "Have", "Want"]
  ShowSortOrder = ["Alphabetical", "Recency"]
  
  # show type
  TypeTvSeries = "TV Series"
  TypeTvEpisode = "TV Episode"
  TypeTvSeason = "TV Season"
  TypeTvMovie = "TV Movie"
  TypeTvMiniSeries = "TV Mini-Series"
  TypeAnimation = "Animation"
  TypeDocumentary = "Documentary"
  TypeMovie = "Movie"
  TypeShortFilm = "Short Film"
  TypeWeb = "Web"
  TypeOther = "Other"
  
  # a nice ordering as well, rather than alpha
  TypeStates = [
    TypeAnimation,
    TypeDocumentary,
    TypeMovie, 
    TypeShortFilm,
    TypeTvSeries, 
    TypeTvSeason, 
    TypeTvEpisode, 
    TypeTvMovie, 
    TypeTvMiniSeries, 
    TypeWeb,
    TypeOther]
  
 #ferret integration
#   acts_as_ferret :fields => { :name => {:store => :yes, :boost => 2}, 
#                               :global_id => {:store => :yes, 
#                                              :index => :untokenized},
#                               :user_id => { :index => :untokenized}
#                             } # :annotations => { :entry, :type }
  
  # validation
  validates_presence_of :name, :user
  validates_length_of    :name,    :within => 1..256
  validates_inclusion_of :intention, :in => Intention_states
  validates_inclusion_of :possession, :in => Possession_states
  validates_inclusion_of :show_type, :in => TypeStates
  
  # relationships
  has_many :annotations, :dependent => :destroy
  has_many :activities, :dependent => :destroy
  
  belongs_to :user
  belongs_to :parent, :class_name => 'Show', :foreign_key => 'parent_id'
  has_many :children, :class_name => 'Show', :foreign_key => 'parent_id', :order=>"name ASC"
  

  before_save :make_default_global_id
  
  # show annotations
  has_many :messages, :order=>"created_at DESC"
  has_many :reviews, :order=>"created_at DESC"
  has_many :plots, :order=>"created_at DESC"
  has_many :pictures, :order=>"created_at DESC"
  has_many :covers, :order=>"created_at DESC"
  has_many :links, :order=>"created_at DESC"
  has_many :videos, :order=>"created_at DESC"

  # other annotations
  has_one :rating, :dependent => :destroy
  has_many :events, :order=>"created_at DESC", :dependent => :destroy
  has_many :requests, :class_name => 'Request', :foreign_key => 'wanted_show_id', :order=>"created_at DESC", :dependent => :destroy

  # named scopes for states (easy filters)
  named_scope :want, :conditions => ["possession=?",Possession_want]
  named_scope :have, :conditions => ["possession=?",Possession_have]
  named_scope :seen, :conditions => ["intention=?",Intention_seen]
  named_scope :unseen, :conditions => ["intention=?",Intention_unseen]
  
  # a note about hot: created recently, and has lots of member recently (member count applied after the where clause!)
  named_scope :hot, :select => 'shows.*, COUNT(global_id) member_count', :conditions=>["created_at>?",1.days.ago], :group=>"global_id", :order=>"member_count DESC"
  # all time popular
  named_scope :popular, :select=>"shows.*, count(global_id) as members_count", :group=>"global_id", :order=>"members_count DESC"
  # recent
  named_scope :recent, :group=>"global_id", :order=>"created_at DESC"

  def full_name
    return self.name if self.parent.nil?
    return "#{self.parent.full_name}: #{self.name}"
  end
  
  # mark the show as seen
  def seen
     self.intention = Intention_seen
#     if is_wanted?
#      self.possession = Possession_unknown
#     end
  end
  
  def unseen
  self.intention = Intention_unseen 
  end
  
  # mark the show as want
  def want
    self.possession = Possession_want
    #self.unseen
  end
  
  # mark the show as have
  def have
    self.possession = Possession_have
    #self.seen
  end
  
  def clear_states
     self.intention = nil
     self.possession = nil
  end
  
  def has_seen?(fuser=self.user)
    fuser_show = get_user_show(fuser)
    if not fuser_show.nil?
      return true if fuser_show.intention == Intention_seen
    end
    return false
  end
  
  def is_wanted?(fuser=self.user)
    fuser_show = get_user_show(fuser)
    if not fuser_show.nil?
      return true if fuser_show.possession == Possession_want
    end
    return false
  end
  
  def is_have?(fuser=self.user)
    fuser_show = get_user_show(fuser)
    if not fuser_show.nil?
      return true if fuser_show.possession == Possession_have
    end
    return false
  end
  
  # find the equivalent show for the given user, where equivalent show is a show of the show with a matching global id
  def get_user_show(other_user)
    if self.user == other_user
      return self
    end
    # attempt to locate it
    return other_user.shows.find_by_global_id(self.global_id)
  end
  
  # gets the equivalent show or clones
  def getorclone_user_show(other_user)
    return get_user_show(other_user) || self.user_clone(other_user)
  end
 
 
  def user_clone(user)
    # clone the current show
    cshow = simple_show_clone(user)

    # clone children down    
    clone_show_children(cshow, self.children, user)
            
    # copy parents all the way up to root
    current = self
    child = cshow    
    parent = nil
    while((parent = current.parent) != nil)
      # acquire the copy (user or clone)
      parent_copy = parent.get_user_show(user) || parent.simple_show_clone(user)    
      # save the parent (get an id)
      parent_copy.save
      # assign the parent to the child
      child.parent_id = parent_copy.id
      # save child in case there are more parents
      child.save
      # swap them out
      current = parent
      child = parent_copy
    end
    
    return cshow
  end
  
  def clone_show_children(parent, children, user)
    for child in children
      baby = child.simple_show_clone(user)
      if baby.parent.nil?
        baby.parent = parent
        baby.save
        # recursive children cloning death
        clone_show_children(baby, child.children, user)
      end
    end
  end
  
  def simple_show_clone(user)
    cshow = clone
    cshow.user = user
    cshow.created_at = Time.now
    cshow.intention = nil
    cshow.possession = nil
    cshow.parent = nil
    return cshow
  end
  
  
  def self.per_page
    20
  end
  
  
  def recent_group_activity(page, limit=5)
    # covers show and annotation activity
    return Activity.paginate(:all, 
      :conditions=>["shows.global_id=?", self.global_id], 
      :include=>:show, 
      :order=>"activities.created_at DESC", 
      :per_page=>(limit.nil? ? Show.per_page : limit),
      :page=>page)
  end
  
  
  
  # users trailer, or random from group
  def trailer
    # why doesn't this work
    self.videos.find(:first) || Video.find(:first, 
      :conditions => ["shows.global_id=?", self.global_id], 
      :include=>:show, :order=>"RAND()")
  end
  
  # users review, or random from group
  def review
    # why doesn't this work
    return self.reviews.find(:first) || Review.find(:first, 
      :conditions => ["shows.global_id=?", self.global_id], 
      :include=>:show, :order=>"RAND()")
  end
  
  # users plot, or random from group
  def plot
    # why doesn't this work
    self.plots.find(:first) || Plot.find(:first, 
      :conditions => ["shows.global_id=?", self.global_id], 
      :include=>:show, :order=>"RAND()")
  end
  

  # users cover, or random from group
  def cover
    return self.covers.find(:first) || Cover.find(:first, 
      :conditions => ["shows.global_id=?", self.global_id], 
      :include=>:show, :order=>"RAND()")
  end

  # group annotations
  def group_annotations(type, limit=nil)
    return Annotation.find(:all, 
      :conditions => ["shows.global_id=? and type=?", self.global_id, type], 
      :include => :show, :limit=>limit, :order=>"annotations.created_at DESC")
  end

  def group_messages(limit=nil)
    return group_annotations("Message", limit)
  end
  
  def count_group_messages
    return Message.count(:all, :conditions => ["shows.global_id=?", self.global_id], :include => :show)
  end
  
  def group_reviews(limit=nil)
    return group_annotations("Review", limit)
  end
  
  def count_group_reviews
    return Review.count(:all, :conditions => ["shows.global_id=?", self.global_id], :include => :show)
  end
  
  def group_plots(limit=nil)
    return group_annotations("Plot", limit)
  end
  
  def group_pictures(limit=nil)
    return group_annotations("Picture", limit)
  end
  
  def group_intentions(limit=nil)
    return group_annotations("Intention", limit)
  end
  
  def group_types(limit=nil)
    return group_annotations("Type", limit)
  end
  
  def group_covers(limit=nil)
    return group_annotations("Cover", limit)
  end
  
  def group_videos(limit=nil)
    return group_annotations("Video", limit)
  end
  
  def group_links(limit=nil)
    return group_annotations("Link", limit)
  end

  def group_shows
    return Show.find(:all, :conditions => ["global_id=?", self.global_id])
  end
  
  def group_members(limit=nil)
    return User.find(:all, 
      :conditions=>["shows.global_id=?", self.global_id], 
      :include=>:shows, :limit=>limit, :order=>"shows.created_at DESC")
  end
  
  def group_events(limit=nil)
    return Event.find(:all, 
      :conditions=>["shows.global_id=?", self.global_id], 
      :include=>:show, :limit=>limit, :order=>"shows.created_at DESC")
  end
  
  
  
  def count_group_members
    return User.count(:all, 
      :conditions=>["shows.global_id=?", self.global_id], :include=>:shows)
  end
  

  
  def self.top_related_for_user(query, user, limit = 50)
     sql = 'select s.*, count(global_id) count, 
              ( select u.id from users u
                join shows s2 
                on u.id = s2.user_id
                where u.id = ? 
                and s2.global_id = s.global_id ) user_has
           from shows s 
           where name like ? 
           group by s.global_id, s.name
           order by count desc
           limit ?'
    return Show.find_by_sql( [sql, user.id, "%#{query}%", limit]) 
  end
  
  def self.top_related(query, limit = 50)
    sql = 'select s.*, count(global_id) count
           from shows s 
           where name like ? 
           group by s.global_id, s.name
           order by count desc
           limit ?'
    return Show.find_by_sql( [sql, "%#{query}%", limit])
  end
  
  def self.find_by_user_and_annotation(user, type, entry, order, page)  

    return Show.paginate_by_sql( ['select s.*
                                   from shows s
                                   right outer join annotations a
                                   on s.id = a.show_id 
                                   where s.user_id = ?
                                   and a.type = ? 
                                   and a.entry = ?
                                   order by s.' + order, user.id, type, entry], :page => page)        
  end
  
  

  
  
  private
  
  def make_default_global_id
    # only create a default global id if not already set
    if self.global_id.nil? or self.global_id.blank?
      self.global_id = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
    end
  end
  
end