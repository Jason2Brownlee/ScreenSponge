class AddTypeToAnnotations < ActiveRecord::Migration
  def self.up
    add_column :annotations, :type, :string, :null => false
    remove_column :annotations, :annotation_type_id
    drop_table :annotation_types
  end

  def self.down
    remove_column :shows, :type
  end
end
