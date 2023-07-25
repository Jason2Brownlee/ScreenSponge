class CreateAnnotationTypes < ActiveRecord::Migration
  def self.up
    create_table :annotation_types do |t|
      t.string :name
      t.string :description
      t.timestamps
    end
    # AnnotationType.create :name => "message", :description => "Message"
    #     AnnotationType.create :name => "link", :description => "Link"
    #     AnnotationType.create :name => "media", :description => "Media"
    #     AnnotationType.create :name => "event", :description => "Event"
    #     AnnotationType.create :name => "rating", :description => "Rating"
    #     AnnotationType.create :name => "viewed", :description => "Viewed"
    #     AnnotationType.create :name => "tag", :description => "Tag"
    #     AnnotationType.create :name => "note", :description => "Note"
  end

  def self.down
    drop_table :annotation_types
  end
end
