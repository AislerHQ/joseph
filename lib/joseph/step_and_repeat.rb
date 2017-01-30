module Joseph
  class StepAndRepeat < FFI::Struct
    layout :x, :int,
      :y, :int,
      :dist_x, :double,
      :dist_y, :double

  end
end