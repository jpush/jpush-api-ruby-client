module JPush
  module Utils
    module Helper
      module ObjectExtensions

        refine Hash do
          def compact
            self.select { |_, value| !value.nil? }
          end
        end

      end
    end
  end
end
