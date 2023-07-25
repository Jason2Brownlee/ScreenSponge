class ChangeShowTypesOnShow < ActiveRecord::Migration
  def self.up
    rename_column :shows, :show_types_id, :show_type_id
  end

  def self.down
    rename_column :shows, :show_type_id, :show_types_id
  end
end
