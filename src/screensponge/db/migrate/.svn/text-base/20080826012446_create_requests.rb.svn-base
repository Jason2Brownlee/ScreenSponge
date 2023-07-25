class CreateRequests < ActiveRecord::Migration
  def self.up
    create_table :requests do |t|
      t.references :requested_show
      t.references :wanted_show
      t.text :message
      
      t.timestamps
    end
  end

  def self.down
    drop_table :requests
  end
end
