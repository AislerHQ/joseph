module Joseph
  class GdkColor < FFI::Struct
    def self.create(r, g, b)
      color = self.new
      color.red = r
      color.green = g
      color.blue = b
      color
    end

    layout :pixel, :uint32,
      :red, :uint16,
      :green, :uint16,
      :blue, :uint16

    def red=(val)
      self[:red] = val.to_gdk_color
    end

    def green=(val)
      self[:green] = val.to_gdk_color
    end

    def blue=(val)
      self[:blue] = val.to_gdk_color
    end

    def hex=(val)
      val.sub! /#/, ''
      self.red = val[0..1].to_i(16)
      self.green = val[2..3].to_i(16)
      self.blue = val[4..5].to_i(16)
    end
  end
end