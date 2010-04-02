module Rubyrel
  module Typing
  
    # 
    # Implements a heading as a set of attributes.
    #
    # A heading is never ordered, so that all iterator/enumerator methods of this 
    # class do not guarantee any enumeration ordering. 
    #
    class Heading
      include Enumerable

      # Attributes as a list
      attr_reader :attributes
  
      ### Heading construction and constants #######################################
  
      # 
      # Initializes the heading with (name,type) pairs provided as a Hash.
      #
      # Raises:
      # + ArgumentError if pairs and not valid (according to invalid_pairs?) 
      #
      def initialize(pairs)
        case pairs
          when Hash
            @attributes = pairs.collect{|pair| Attribute.new(pair[0], pair[1])}
            @attributes.sort!{|a1,a2| a1.name.to_s <=> a2.name.to_s}
          else
            raise ArgumentError, "Invalid attributes for heading #{pairs.inspect}"
        end
      end
  
      # Empty heading constant
      EMPTY_HEADING = Rubyrel::Typing::Heading.new({})
    
      ### Heading accessors and utilities ##########################################
    
      # 
      # Returns the degree (aka arity) of this heading.
      #
      # By definition, the degree of a heading is the number of (name, type) 
      # pairs in the heading. 
      # 
      def degree() @attributes.size end
  
      # 
      # Checks if this heading is empty.
      #  
      # By definition, an heading is empty if it's degree is equal to 0. 
      #
      def empty?() degree==0 end
  
      # 
      # Returns an array containing attribute names of this heading.
      #
      # Please note that, by definition, (name,type) pairs of a heading are 
      # never ordered (a heading is a unordered mathematical set). So this
      # method does not ensure any particular order of attribute names. 
      #
      def attribute_names() @attributes.collect{|a| a.name} end
  
      # 
      # Checks if an attribute exists in this heading.
      # 
      # The name of the attribute must be provided as a Symbol. This method
      # always return false otherwise.
      #
      def has_attr?(name) @attributes.any?{|a| a.name == name} end
  
      # 
      # Returns the domain (a Ruby class) associated to an attribute, nil if no 
      # such attribute.
      #
      # The name of the attribute must be provided as a Symbol. This method
      # always return nil otherwise.
      #
      def domain_of(name) 
        attribute = @attributes.find{|a| a.name == name} 
        attribute ? attribute.domain : nil
      end

      # Yields the block with each attribute in the heading.
      def each(&block) @attributes.each(&block) end


      ### Type checking ############################################################
      
      # Checks if a ruby Hash looks like a valid ruby literal for this heading
      def valid_ruby_literal?(pairs)
            (Hash === pairs) \
        && (pairs.size == degree) \
        && all?{|a| a.domain.rel_belongs?(pairs[a.name])}
      end
    

      ### Equality, hash code, to_s, ... ###########################################
  
      # 
      # Checks equality with another heading
      #
      # Two headings are equal if and only if they map exactly the same attribute
      # names to the same attribute types.
      #
      def ==(other)
        return false unless other.is_a?(Heading) and (hash == other.hash)
        return @attributes == other.attributes
      end
  
      # Semantically equivalent to <tt>self==(other)</tt>
      def eql?(other) self.==(other) end
  
      # Semantically equivalent to <tt>self==(other)</tt>
      def equal?(other) self.==(other) end
  
      # 
      # Computes an hash code for this heading.
      #
      # This method ensures that two headings that are equals according to
      # <tt>==()</tt> have the same hash code. 
      # 
      def hash() @hash_code ||= attributes.hash; end
    
      # 
      # Returns a string representation of this heading definition 
      #
      # This method does not ensure any particular order of (name,type) pairs
      # in the resulting representation.
      #
      def definition
        defn = @attributes.sort{|a1, a2| a1.name.to_s <=> a2.name.to_s}.inject("") do |memo,k|
          memo << ", :#{k.name} => #{k.domain}" 
        end 
        "(#{defn[2..-1]})"
      end
    
      # 
      # Returns a string representation of this heading. 
      #
      # This method does not ensure any particular order of (name,type) pairs
      # in the resulting representation.
      #
      def to_s
        definition
      end

    end # class Heading
  end # module Typing
end # module Rubyrel