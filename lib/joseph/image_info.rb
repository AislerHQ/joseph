module Joseph
  class ImageInfo < FFI::Struct
    layout :name, :string,
      :polarity, :int,
      :min_x, :double,
      :min_y, :double,
      :max_x, :double,
      :max_y, :double,
      :offset_a, :double,
      :offset_b, :double,
      :encoding, :int,
      :rotation, :double,
      :justify_type_a, :int,
      :justify_type_b, :int,
      :justify_offset_a, :double,
      :justify_offset_b, :double,
      :justify_offset_actual_a, :double,
      :justify_offset_actual_a, :double,
      :plotter_film, :string,
      :type, :string,
      :hid_attribute, :pointer,
      :n_attr, :int

  end
end