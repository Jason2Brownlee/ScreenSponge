class FriendActivity < Activity
  
  
  validates_presence_of :user
  validates_presence_of :friend
  validates_presence_of :note
  
  def self.new_friend(a_user, a_friend)
    activity = FriendActivity.new
    activity.user = a_user
    activity.friend = a_friend
    activity.note = "are now friends"
    activity.save
  end
  
end
