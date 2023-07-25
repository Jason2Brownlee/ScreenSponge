class AddUniqueIndexShows < ActiveRecord::Migration
  def self.up
     add_index :shows, [:user_id, :global_id], :unique => true
     add_index :shows, :user_id
     add_index :shows, :global_id
     add_index :annotations, :show_id
  end

  def self.down
    remove_index :shows, [:user_id, :global_id]
    remove_index :shows, :user_id
    remove_index :shows, :global_id
    remove_index :annotations, :show_id
  end
end
