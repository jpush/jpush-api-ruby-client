module JPush
  class TagAlias
    attr_accessor :add, :remove, :alias ,:tags
    def initialize(opts = {})
      if opts[:add] != nil
        if  opts[:add].class == Array
          @add = opts[:add]
        else
          raise ArgumentError.new('add should be array.')
        end
      end

      if opts[:remove] != nil
        if  opts[:remove].class == Array
          @remove = opts[:remove]
        else
          raise ArgumentError.new('add should be array.')
        end
      end

      if opts[:alias] != nil
        @alias = opts[:alias]
      end
    end

    def toJSON
      hash = {}
      tags = {}
      if @add != nil
        tags['add'] = @add
      end
      if @remove != nil
        tags['remove'] = @remove
      end
      if @alias != nil
        hash['alias'] = @alias
      end
      if @tags == ''
       hash['tags'] = @tags
       else
         hash['tags'] = tags  
      end
      
      return hash
    end

      
    
    
    def self.clear
      tags = JPush::TagAlias.new
      tags.tags = ''
      tags.alias = ''
      return tags;
    end
    
    def self.build(opts = {})
      tagAlias = JPush::TagAlias.new(opts)
      return tagAlias
    end
  end
end