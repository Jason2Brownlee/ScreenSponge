class Friendship < ActiveRecord::Base
  
  # relationships
  belongs_to :user
  belongs_to :friend, :class_name => 'User', :foreign_key => 'friend_id'
  
  ACCEPTED = "accepted"
  PENDING = "pending"
  REQUESTED = "requested"
  
  STATES = [ACCEPTED, PENDING, REQUESTED]
  
  validates_presence_of :user, :friend, :status
  validates_inclusion_of :status, :in => STATES
  
  # named scopes
  named_scope :accepted, :conditions=>["status=?",Friendship::ACCEPTED]
  named_scope :pending, :conditions=>["status=?",Friendship::PENDING]
  named_scope :requested, :conditions=>["status=?",Friendship::REQUESTED]
  
  # helpers
    
  def is_accepted?
    return self.status==ACCEPTED
  end
  def is_pending?
    return self.status==PENDING
  end
  def is_requested?
    return self.status==REQUESTED
  end
  
end
