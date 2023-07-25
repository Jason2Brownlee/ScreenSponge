class Addusertoshows < ActiveRecord::Migration
  def self.up
     add_column :shows, :user_id, :integer, :null => false
  end

  def self.down
    remove_column :shows, :user_id
  end
end
