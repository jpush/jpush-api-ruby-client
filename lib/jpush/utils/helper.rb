module JPush
  module Utils
    module Helper
      module ObjectExtensions

        refine Object do

          def jpush_symbolize_keys!
            return self.inject({}){ |memo, (k, v)| memo[k.to_sym] = v.jpush_symbolize_keys!; memo } if self.is_a? Hash
            return self.inject([]){ |memo, v     | memo          << v.jpush_symbolize_keys!; memo } if self.is_a? Array
            return self
          end

          # An object is blank if it's false, empty, or a whitespace string.
          # For example, false, '', ' ', nil, [], and {} are all blank.
          def blank?
            respond_to?(:empty?) ? !!empty? : !self
          end

        end

        refine String do
          BLANK_RE = /\A[[:space:]]*\z/
          WORD_RE = /\A[\p{han}a-zA-Z0-9_]+\z/u

          def titleize
            self.split(' ').map(&:capitalize).join(' ')
          end

          def blank?
            BLANK_RE === self
          end

          def valid_word?
            WORD_RE === self
          end
        end

        refine Hash do
          def compact
            self.select { |_, value| !value.nil? }
          end
        end

      end
    end
  end
end
