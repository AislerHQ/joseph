module CoreExtensions
  module Float
    module Conversions
      def to_inches
        self / 25.4
      end

      def to_mm
        self  * 25.4
      end
    end
  end
end
