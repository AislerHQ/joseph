module Joseph
  class Cirseg < FFI::Struct
    layout :cp_x, :double,
      :cp_y, :double,
      :width, :double,
      :height, :double,
      :angle1, :double,
      :angle2, :double

  end
end