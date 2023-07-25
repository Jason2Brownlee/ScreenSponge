class AddColumnsShow < ActiveRecord::Migration
  def self.up
    add_column :shows, :runtime, :integer
    add_column :shows, :genre, :string
    add_column :shows, :release_date, :integer
  end

  def self.down
    remove_column :shows, :runtime
    remove_column :shows, :genre
    remove_column :shows, :release_date
  end
end
