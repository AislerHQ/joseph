module Joseph
  class FileInfo < FFI::Struct
    layout :image, Image.by_ref,
      :color, GdkColor.by_value,
      :alpha, :uint16,
      :is_visible, :int,
      :private_render_data, :pointer,
      :full_pathname, :string,
      :name, :string,
      :transform, UserTransformation.by_value,
      :layer_dirty, :int

    def image
      self[:image]
    end
  end
end