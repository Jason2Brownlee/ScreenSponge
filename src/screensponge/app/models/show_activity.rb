class ShowActivity < Activity
  
  validates_presence_of :user
  validates_presence_of :show
  validates_presence_of :note
  
  def self.new_show(a_show, a_user)
    activity = ShowActivity.new
    activity.user = a_user
    activity.show = a_show
    activity.note = "added show"
    activity.save
  end
  
  def self.update_show(a_show, a_user)
    activity = ShowActivity.new
    activity.user = a_user
    activity.show = a_show
    activity.note = "updated show"
    activity.save
  end
  
  def self.rated_show(a_show, a_user)
    activity = ShowActivity.new
    activity.user = a_user
    activity.show = a_show
    activity.note = "gave the rating #{a_show.rating.score}/10 to show"
    activity.save
  end
  
end
