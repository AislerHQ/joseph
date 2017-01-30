module Joseph
  class UserTransformation < FFI::Struct
    layout :translate_x, :double,
      :translate_y, :double,
      :scale_x, :double,
      :scale_y, :double,
      :rotation, :double,
      :mirror_around_x, :int,
      :mirror_around_y, :int,
      :inverted, :int

    def initialize(address = nil)
      super(address)
      self[:scale_x] = 1.0
      self[:scale_y] = 1.0
    end
  end
end