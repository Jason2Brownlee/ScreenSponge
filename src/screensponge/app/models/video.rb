class Video < Annotation
  
  belongs_to :show
  
  validates_presence_of :entry
  
  
end
