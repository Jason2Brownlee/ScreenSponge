class Activity < ActiveRecord::Base
  
  # relationships
  belongs_to :user
  belongs_to :friend, :class_name => 'User', :foreign_key => 'friend_id'
  belongs_to :show
  belongs_to :annotation
  
  # named scopes
  named_scope :recent, :order=>"created_at DESC"
  
  
end
