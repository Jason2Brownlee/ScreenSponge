class Request < ActiveRecord::Base

  belongs_to :requested_show, :class_name => 'Show', :foreign_key => 'requested_show_id'
  belongs_to :wanted_show, :class_name => 'Show', :foreign_key => 'wanted_show_id'
  
  validates_presence_of :requested_show, :wanted_show

  
  
  def self.user_has_requested(user)
    return Request.find(:all, 
      :conditions=>["shows.user_id=? and closed<>1", user.id],
      :include=>:wanted_show, 
      :order=>"requests.created_at DESC")
  end
  
  
  def self.requested_against_user(user)
    return Request.find(:all,
      :conditions=>["shows.user_id=? and closed<>1", user.id],
      :include=>:requested_show, 
      :order=>"requests.created_at DESC")
  end
  
  
  
  def self.get_request(requestor, requested, show)
    return Request.find_by_sql(['select r.* 
                                from requests r
                                join shows sr on r.requested_show_id = sr.id
                                join shows sw on r.wanted_show_id = sw.id
                                where sw.id = ?
                                and sw.user_id = ?
                                and sr.user_id = ?
                                and r.closed = false
                                order by r.created_at desc', show.id, requestor.id, requested.id])
                                
  end
  def self.get_requested(requested, requestor, show)
        return Request.find_by_sql(['select r.* 
                                from requests r
                                join shows sr on r.requested_show_id = sr.id
                                join shows sw on r.wanted_show_id = sw.id
                                where sr.id = ?
                                and sw.user_id = ?
                                and sr.user_id = ?
                                and r.closed = false
                                order by r.created_at desc', show.id, requestor.id, requested.id])
  end
  
end
