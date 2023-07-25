class CreateShows < ActiveRecord::Migration
  def self.up
    create_table :shows do |t|
      t.references :show_types, :null => false
      t.string :name, :null => false
      t.text :description
      t.text :note
      t.integer :rating
      t.text :tags

      t.timestamps
    end
  end

  def self.down
    drop_table :shows
  end
end
