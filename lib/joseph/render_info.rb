module Joseph
  class RenderInfo < FFI::Struct
    layout :scale_factor_x, :double,
      :scale_factor_y, :double,
      :lower_left_x, :double,
      :lower_left_y, :double,
      :render_type, :uint,
      :display_width, :int,
      :display_height, :int
  end
end