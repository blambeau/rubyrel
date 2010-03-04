module Rubyrel
  module Tools
    class Cesure
      
      # A group in the Cesure algorithm
      class Group
        
        # Cesure algorithm instance
        attr_reader :cesure
        
        # Index of the group in the group list
        attr_reader :index
        
        # Attribute on which the group works
        attr_reader :attribute
        
        # Order (:asc or :desc)
        attr_reader :order
        
        # Creates a group instance
        def initialize(cesure, index, attribute, order)
          @cesure, @index, @attribute, @order = cesure, index, attribute, order
        end
        
        # Returns the next group, or nil if this one is the last one.
        def next_group
          @cesure.groups(self.index + 1)
        end
        
      end # class Group
      
      # Groups 
      attr_reader :groups
      
      # Creates an empty Cesure algorithm instance
      def initialize
        @groups = []
      end
      
      # Adds a group
      def add_group(attribute, order = :asc)
        @groups << (group = Group.new(self, @groups.size, attribute, order))
        group
      end
      
    end # class Cesure
  end # module Tools
end # module Rubyrel