class CreateShowUrlTypes < ActiveRecord::Migration
  def self.up
    create_table :show_url_types do |t|
      t.string :name
      t.text :description
    end

    # ShowUrlType.create :name => "imbd", :description => "IMDB"
    #     ShowUrlType.create :name => "youtube", :description => "You Tube"
    #     ShowUrlType.create :name => "official", :description => "Offical Site"
    #     ShowUrlType.create :name => "other", :description => "Other"
    #     ShowUrlType.create :name => "review", :description => "Review"
    #     ShowUrlType.create :name => "acquire", :description => "Acquire/Purchase"
    
  end

  def self.down
    drop_table :show_url_types
  end
end
