class CreateMedias < ActiveRecord::Migration
  def self.up
    create_table :medias do |t|
      t.string :name
      t.text :description
    end
    
    # Media.create :name => "cinema", :description => "Cinema"
    #     Media.create :name => "dvd", :description => "DVD"
    #     Media.create :name => "tv", :description => "Television"
    #     Media.create :name => "cable", :description => "Cable TV"
    #     Media.create :name => "hddvd", :description => "HD-DVD"
    #     Media.create :name => "online", :description => "Online video eg. Hulu"
    #     Media.create :name => "file", :description => "Offline avi file"
    #     Media.create :name => "itunes", :description => "Apple iTunes"
    #     Media.create :name => "other", :description => "Other"
  end

  def self.down
    drop_table :medias
  end
end
