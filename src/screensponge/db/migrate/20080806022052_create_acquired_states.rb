class CreateAcquiredStates < ActiveRecord::Migration
  def self.up
    create_table :acquired_states do |t|
      t.string :name
      t.text :description
    end
    
    # AcquiredState.create :name => "bought", :description => "Bought"
    #     AcquiredState.create :name => "wish", :description => "Wish List"
    #     AcquiredState.create :name => "none", :description => "None"
  end

  def self.down
    drop_table :acquired_states
  end
end
