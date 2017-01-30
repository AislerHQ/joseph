module Joseph
  module Bridge
    extend FFI::Library
    ffi_lib 'libgerbv'

    # http://gerbv.geda-project.org/doxygen/gerbv_8h.html#ac99303749c4afdc6a24eafbfa37e1237
    enum :aptype, [:none, 1,
                :circle,
                :rectangle,
                :oval,
                :polygon,
                :macro ]

    # http://gerbv.geda-project.org/doxygen/index.html
    attach_function :gerbv_create_project, [], Project.ptr
    attach_function :gerbv_create_image, [:pointer, :pointer], Image.ptr

    attach_function :gerbv_open_layer_from_filename, [:pointer, :string], :void
    attach_function :gerbv_open_layer_from_filename_with_color, [:pointer, :string, :int, :int, :int, :int], :void

    attach_function :gerbv_export_png_file_from_project, [:pointer, :pointer, :string], :void
    attach_function :gerbv_export_png_file_from_project_autoscaled, [:pointer, :int, :int, :string], :void
    attach_function :gerbv_export_svg_file_from_project_autoscaled, [:pointer, :string], :void

    attach_function :gerbv_export_rs274x_file_from_image, [:string, :pointer, :pointer], :bool
    attach_function :gerbv_export_drill_file_from_image, [:string, :pointer, :pointer], :bool

    attach_function :gerbv_render_get_boundingbox, [:pointer, :pointer], :void
    attach_function :gerbv_render_zoom_to_fit_display, [:pointer, :pointer], :void

    attach_function :gerbv_image_copy_image, [:pointer, :pointer, :pointer], :void
    attach_function :gerbv_image_duplicate_image, [:pointer, :pointer], Image.ptr
    attach_function :gerbv_image_create_line_object, [:pointer, :double, :double, :double, :double, :double, :aptype], :void
    attach_function :gerbv_image_create_arc_object, [:pointer, :double, :double, :double, :double, :double, :double, :aptype], :void
    attach_function :gerbv_image_create_rectangle_object, [:pointer, :double, :double, :double, :double], :void
    attach_function :gerbv_image_delete_net, [:pointer], :void

    attach_function :gerbv_image_return_new_layer, [:pointer], Layer.ptr
    attach_function :gerber_create_new_net, [:pointer, :pointer, :pointer], Net.ptr

    attach_function :gerbv_destroy_project, [:pointer], :void
    attach_function :gerbv_destroy_image, [:pointer], :void
  end

end