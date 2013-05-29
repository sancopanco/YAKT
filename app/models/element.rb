class Element < ActiveRecord::Base
   ELEMENT_TYPES = ["Image", "Html","Label","Video",
                      "IntType", "StrType","DateType"]
   attr_accessible :name,:element_object_type
   belongs_to :element_object,:polymorphic=>true, :autosave=>true
   after_create :setup_element_object
   after_destroy :delete_element_object
  
   def  delete_element_object
     self.element_object.destroy
   end
   def setup_element_object
     if ELEMENT_TYPES.include?(element_object_type)  
        #self.element_object = ElementType.get_instance_by_type(element_object_type)
        #cls = Class.new(ActiveRecord::Base) do
        #  self.table_name = table_name
        #end
        self.element_object = element_object_type.constantize.create!
        self.save!
      end
   end
end