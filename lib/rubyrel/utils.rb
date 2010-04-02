module Rubyrel
  module Utils

    # Seed number
    SEED = 23
    
    # Prime number
    PRIME = 37
    
    # Computes hash code for different kind of objects
    def hash(who)
      case who
        when Hash
          hash_hash(who)
        when Array
          hash_array(who)
        else
          who.hash  
      end
    end
    module_function :hash
  
    # Computes an hash code for a Hash
    def hash_hash(h)
      code = SEED
      keys = h.keys.sort do |h1,h2| 
        if h1.respond_to?(:<=>)
          h1 <=> h2
        else
          h1.to_s <=> h2.to_s
        end
      end
      keys.each do |k|
        code = code*PRIME + hash(k)
        code = code*PRIME + hash(h[k])
      end
      return code
    end
    module_function :hash_hash
  
    # Computes an hash code for a Hash
    def hash_array(arr)
      code = SEED
      arr.each do |v|
        code = code*PRIME + hash(v)
      end
      return code
    end
    module_function :hash_array
  
  end # module Utils
end # module Ruby 