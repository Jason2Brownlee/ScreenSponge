class CreateAnnotations < ActiveRecord::Migration
  def self.up
    create_table :annotations do |t|
      t.references :show
      t.references :annotation_type
      t.text :data

      t.timestamps
    end
  end

  def self.down
    drop_table :annotations
  end
end
