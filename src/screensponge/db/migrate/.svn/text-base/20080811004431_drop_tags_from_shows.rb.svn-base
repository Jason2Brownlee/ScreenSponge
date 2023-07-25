class DropTagsFromShows < ActiveRecord::Migration
  def self.up
    remove_column :shows, :tags
    rename_column :shows, :note, :synopsis
    # AnnotationType.create :name => "review", :description => "Review"
  end

  def self.down
    add_column :shows, :tags, :text
    rename_column :shows, :synopsis, :note
  end
end
