module Jpush
  module Utils
    module Helper
      refine Object do
        def jpush_symbolize_keys!
          return self.inject({}){ |memo, (k, v)| memo[k.to_sym] = v.jpush_symbolize_keys!; memo } if self.is_a? Hash
          return self.inject([]){ |memo, v     | memo          << v.jpush_symbolize_keys!; memo } if self.is_a? Array
          return self
        end
      end
    end
  end
end
