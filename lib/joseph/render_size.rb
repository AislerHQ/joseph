module Joseph
  class RenderSize < FFI::Struct
    def self.from_image(image)
      rs = self.new
      rs[:left] = image.info[:min_x]
      rs[:right] = image.info[:max_x]
      rs[:top] = image.info[:min_y]
      rs[:bottom] = image.info[:max_y]
      rs
    end

    layout :left, :double,
      :right, :double,
      :bottom, :double,
      :top, :double

    def valid?
      !(self[:right].infinite? || self[:left].infinite? || self[:top].infinite? || self[:bottom].infinite?)
    end

    def to_s
      "Right #{self[:right]} / Left #{self[:left]} / Top #{self[:top]} / Bottom #{self[:bottom]}"
    end

    def width
      (self[:right] - self[:left]).abs
    end

    def height
      (self[:top] - self[:bottom]).abs
    end

    def left
      self[:left]
    end

    def right
      self[:right]
    end

    def top
      self[:top]
    end

    def bottom
      self[:bottom]
    end
  end

end