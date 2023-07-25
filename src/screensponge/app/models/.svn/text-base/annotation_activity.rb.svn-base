class AnnotationActivity < Activity
  
  validates_presence_of :user
  validates_presence_of :show
  validates_presence_of :annotation
  validates_presence_of :note
  
  def self.new_plot(a_show, a_user, a_annotation)
    activity = AnnotationActivity.new
    activity.user = a_user
    activity.show = a_show
    activity.annotation = a_annotation
    activity.note = "wrote a new synopsis for show"
    activity.save
  end
  
  def self.update_plot(a_show, a_user, a_annotation)
    activity = AnnotationActivity.new
    activity.user = a_user
    activity.show = a_show
    activity.annotation = a_annotation
    activity.note = "updated a plot for show"
    activity.save
  end
  
  def self.new_message(a_show, a_user, a_annotation)
    activity = AnnotationActivity.new
    activity.user = a_user
    activity.show = a_show
    activity.annotation = a_annotation
    activity.note = "posted a new message on show"
    activity.save
  end
  
  def self.new_review(a_show, a_user, a_annotation)
    activity = AnnotationActivity.new
    activity.user = a_user
    activity.show = a_show
    activity.annotation = a_annotation
    activity.note = "wrote a new review for show"
    activity.save
  end
  
  def self.new_picture(a_show, a_user, a_annotation)
    activity = AnnotationActivity.new
    activity.user = a_user
    activity.show = a_show
    activity.annotation = a_annotation
    activity.note = "added a new picture to show"
    activity.save
  end
  
  def self.new_cover(a_show, a_user, a_annotation)
    activity = AnnotationActivity.new
    activity.user = a_user
    activity.show = a_show
    activity.annotation = a_annotation
    activity.note = "added a new cover to show"
    activity.save
  end
  
  def self.new_link(a_show, a_user, a_annotation)
    activity = AnnotationActivity.new
    activity.user = a_user
    activity.show = a_show
    activity.annotation = a_annotation
    activity.note = "added a new link to show"
    activity.save
  end
  
  def self.new_video(a_show, a_user, a_annotation)
    activity = AnnotationActivity.new
    activity.user = a_user
    activity.show = a_show
    activity.annotation = a_annotation
    activity.note = "added a trailer to show"
    activity.save
  end
  
  def self.new_intention(a_show, a_user, a_annotation)
    activity = AnnotationActivity.new
    activity.user = a_user
    activity.show = a_show
    activity.annotation = a_annotation
    can_save = false
    if a_annotation.entry == Intention.seen
      activity.note = "has seen show"
      can_save = true
    elsif a_annotation.entry == Intention.unseen
      activity.note = "wants to see show"
      can_save = true
    end 
    activity.save if can_save
  end
  
end
