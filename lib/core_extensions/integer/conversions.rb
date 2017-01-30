module CoreExtensions
  module Integer
    module Conversions
      def to_gdk_color
        2**16 / 2**8 * self
      end
    end
  end
end
