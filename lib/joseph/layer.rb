module Joseph
  class Layer < FFI::Struct
    layout :step_and_repeat, StepAndRepeat.by_value,
      :knockout, Knockout.by_value,
      :rotation, :double,
      :polarity, :int,
      :name, :string,
      :next, :pointer

  end
end