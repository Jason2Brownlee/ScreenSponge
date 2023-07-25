class CreateViewStates < ActiveRecord::Migration
  def self.up
    create_table :view_states do |t|
      t.string :name
      t.text :description
    end
    
    # ViewState.create :name => "seen", :description => "Seen"
    #    ViewState.create :name => "unseen", :description => "Unseen"
    #    ViewState.create :name => "want", :description => "Want to see"
  end

  def self.down
    drop_table :view_states
  end
end
