module JPush
  class TagManager
     attr_accessor :add, :remove
     
    def initialize(opts = {})
      if opts[:add] != nil
        if  opts[:add].class == Array && opts[:add].length <= 1000
          @add = opts[:add]
        else
          raise ArgumentError.new('add should be array and size <= 1000.')
        end
      end

      if opts[:remove] != nil
        if  opts[:remove].class == Array && opts[:remove].length <= 1000
          @remove = opts[:remove]
        else
          raise ArgumentError.new('add should be array and size <= 1000.')
        end
      end

    end

    def toJSON
      hash = {}
      registration_ids = {}
      if @add != nil
        registration_ids['add'] = @add
      end
      if @remove != nil
        registration_ids['remove'] = @remove
      end

      hash['registration_ids'] = registration_ids
      return hash
    end
    
     def self.build(opts = {})
      tm = JPush::TagManager.new(opts)
      return tm
    end
    
  end
end
