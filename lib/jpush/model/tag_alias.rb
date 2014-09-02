module JPush
  class TagAlias
    attr_accessor :add, :remove, :alias
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
      hash['tags'] = tags
      return hash
    end

    def self.deleteAlias(add, remove)
      tagAlias = JPush::TagAlias.new
      
      if add != nil
        if  add.class == Array
          tagAlias.add = add
        else
          raise ArgumentError.new('add should be array.')
        end
      end

      if remove != nil
        if  remove.class == Array
          tagAlias.remove = remove
        else
          raise ArgumentError.new('add should be array.')
        end
      end
      
      return tagAlias
    end
    
    def deleteAllTag(_alias)
      tagAlias = JPush::TagAlias.new
      tagAlias.alias = _alias
      return tagAlias
    end
    
    def self.build(opts = {})
      tagAlias = JPush::TagAlias.new(opts)
      return tagAlias
    end
  end
end