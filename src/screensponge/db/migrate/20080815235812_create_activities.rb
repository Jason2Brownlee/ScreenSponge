class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.references :show
      t.text :note
      t.string :type
      t.references :user
      t.integer :friend_id
      t.references :annotation

      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
