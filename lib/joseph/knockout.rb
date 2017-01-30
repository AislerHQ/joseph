module Joseph
  class Knockout < FFI::Struct
    layout :first_instance, :bool,
      :type, :int,
      :polarity, :int,
      :lower_left_x, :double,
      :lower_left_y, :double,
      :width, :double,
      :height, :double,
      :border, :double

  end
end