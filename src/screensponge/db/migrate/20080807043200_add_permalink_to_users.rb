class AddPermalinkToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :permalink, :string
    
    # ensure all users have a permalink (caught in before_save filter)
    # for u in User.all
    #       u.save!
    #     end
    
  end

  def self.down
    remove_column :users, :permalink
  end
end
