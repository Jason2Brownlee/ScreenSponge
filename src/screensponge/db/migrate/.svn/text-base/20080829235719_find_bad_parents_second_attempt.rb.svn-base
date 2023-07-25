class FindBadParentsSecondAttempt < ActiveRecord::Migration
  def self.up
    # users
    for user in User.all
      # shows with parents that do not belong to the user
      shows = Show.find(:all,
        :joins=>"INNER JOIN shows as parents on parents.id = shows.parent_id",
        :conditions=>["shows.user_id=? AND parents.user_id<>?", user.id, user.id])      
      # clone and link the parent
      for show in shows
        #  get the parent
        parent = show.parent        
        # clone and save the parent for the user
        parent_clone = parent.get_user_show(user)
        if parent_clone.nil?
          parent_clone = parent.simple_show_clone(user)
          parent_clone.save!
        end
        # set the new parent and save
        # retrieve again so it can be changed 
        show = Show.find(show)
        show.parent_id = parent_clone.id
        show.save!
      end
    end
  end

  def self.down
  end
end
