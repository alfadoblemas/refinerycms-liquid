module RefinedLiquid
  module ActiveRecord
    module Droppable
      
      def get_drop_class(class_obj)
        begin 
          drop_string = class_obj.to_s + "Drop"
          drop_class = drop_string.constantize
          drop_class
        rescue
          get_drop_class class_obj.superclass
        end
      end
      
      def to_liquid
        drop_class = get_drop_class self.class
        drop_class.new self
      end
      
      def collection_label
        if respond_to? :label then return label end
        if respond_to? :title then return title end
        if respond_to? :name then return name end
        "label for item number :#{id}" 
      end
      
    end
  end
end

Dir[File.dirname(__FILE__) + "/drops/*.rb"].each {|drop| require drop }
Dir[File.dirname(__FILE__) + "/filters/*.rb"].each {|filter| require filter }

ActiveRecord::Base.send(:include, RefinedLiquid::ActiveRecord::Droppable)
