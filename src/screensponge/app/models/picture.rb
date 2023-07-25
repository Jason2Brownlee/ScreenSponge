class Picture < Annotation
  
  belongs_to :show
  
  validates_presence_of :entry
  # check for valid url - can access it 
  # validates_uri_existence_of :entry, :with => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  
  # TODO - check for image file extentions
  #validates_format_of :data, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
  
end
