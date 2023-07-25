class CreateFriendships < ActiveRecord::Migration
  def self.up
    create_table :friendships do |t|
      t.references :user, :null => false
      t.integer :friend_id, :null => false
      t.string :status, :null => false
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :friendships
  end
end
