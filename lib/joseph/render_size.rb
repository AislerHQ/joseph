module Joseph
  class RenderSize < FFI::Struct
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
  end

end