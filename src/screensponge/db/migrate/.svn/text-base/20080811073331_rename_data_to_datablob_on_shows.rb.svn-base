class RenameDataToDatablobOnShows < ActiveRecord::Migration
  def self.up
    rename_column :annotations, :data, :entry
  end

  def self.down
    rename_column :annotations, :entry, :data
  end
end
