class RemoveInvalidShowParents < ActiveRecord::Migration
  def self.up
    
    # users
    for user in User.all
      # shows with parents that do not belong to the user
      shows = user.shows.find(:all,
        :joins=>"INNER JOIN shows as parents on parents.id = shows.parent_id",
        :conditions=>["parents.user_id != ?", user.id])      
      # kill the link to parent
      for show in shows
        show.parent = nil
        show.save
      end
    end
    
    
  end

  def self.down
  end
end
