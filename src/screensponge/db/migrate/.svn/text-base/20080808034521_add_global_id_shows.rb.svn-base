class AddGlobalIdShows < ActiveRecord::Migration
  def self.up
    add_column :shows, :global_id,  :string
    remove_column :shows, :rating
    remove_column :shows, :genre
    remove_column :shows, :runtime
  end

  def self.down
    remove_column :shows, :global_id
  end
end
