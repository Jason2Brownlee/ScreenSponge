class AddClosedTimestampRequests < ActiveRecord::Migration
  def self.up
    add_column :requests, :closed, :boolean, :default => false
  end

  def self.down
    remove_column :requests, :closed
  end
end
