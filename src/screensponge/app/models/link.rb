class Link < Annotation
  
  belongs_to :show
  
  validates_presence_of :entry
  # virtual
  # validates_presence_of :address
  #   validates_presence_of :description
  
  # before_save :build_entry
  #   
  #   def self.partition
  #     # something not in a url, and unlikely to start a description
  #     "\n\n<<>>"
  #   end
  #   
  #   def address
  #     return "" if self.entry.nil?
  #     split = self.entry.split(Link.partition, 2)
  #     return split.first
  #   end
  #   
  #   def description
  #     return "" if self.entry.nil?
  #     split = self.entry.split(Link.partition, 2)
  #     return split.last
  #   end
  #   
  #   def address=(var)
  #     @address = var
  #   end
  #   
  #   def description=(var)
  #     @description = var
  #   end
  #   
  #   private
  #   
  #   def build_entry
  #     entry = [self.address, self.description].join(Link.partition) 
  #   end
  
end
