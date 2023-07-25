class RemoveSynopsisFromShows < ActiveRecord::Migration
  def self.up
    remove_column :shows, :synopsis
    drop_table :medias
    drop_table :show_url_types
    drop_table :notification_types
    drop_table :acquired_states
  end

  def self.down
  end
end
