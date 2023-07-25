class ShowsAddIntentionPossession < ActiveRecord::Migration
  def self.up
    add_column :shows, :intention, :integer
    add_column :shows, :possession, :integer
    
#    users = User.find(:all)
#    users.each do |user|
#      user.shows.each do |show|
#        if not show.intentions.empty?
#          if show.intentions.first.entry == 'Seen'
#            show.intention = Intention::Seen_num
#          end
#          show.intentions.clear
#          show.save
#        end 
#      end
#    end
  end
  
  def self.down
    remove_column :shows, :intention
    remove_column :shows, :possession
  end
end
