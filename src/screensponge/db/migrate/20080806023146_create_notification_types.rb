class CreateNotificationTypes < ActiveRecord::Migration
  def self.up
    create_table :notification_types do |t|
      t.string :name
      t.text :description
    end
    
    # NotificationType.create :name => "cinema", :description => "Cinema Premium"
    #     NotificationType.create :name => "tv episode", :description => "TV Episode"
    #     NotificationType.create :name => "tv season", :description => "TV Season"
    #     NotificationType.create :name => "dvd release", :description => "DVD Release"
    #     NotificationType.create :name => "other", :description => "Other"
  end

  def self.down
    drop_table :notification_types
  end
end
