class Annotation < ActiveRecord::Base
  
  belongs_to :show
  has_many :activities, :dependent => :destroy
  
  validates_presence_of :entry
end
