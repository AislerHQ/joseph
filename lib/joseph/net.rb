module Joseph
  class Net < FFI::Struct
    layout :start_x, :double,
      :start_y, :double,
      :stop_x, :double,
      :stop_y, :double,
      :bounding_box, RenderSize.by_value,
      :aperture, :int,
      :aperture_state, :int,
      :interpolation, :int,
      :cirseg, Cirseg.by_ref,
      :next, :pointer,
      :label, :string,
      :layer, :pointer,
      :state, :pointer

    def hash
      [
        self[:start_x],
        self[:start_y],
        self[:stop_x],
        self[:stop_y]
      ].hash
    end

    def length
      (Vector[self[:start_x], self[:start_y]] - Vector[self[:stop_x], self[:stop_y]]).r
    end

    def flash?
      self[:aperture_state] == 2
    end

    def destroy!
      Binding.gerbv_image_delete_net(self)
    end
  end
end
