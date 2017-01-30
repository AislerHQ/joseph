module Joseph
  class Aperture < FFI::Struct
    layout :type, :int,
      :amacro, :pointer,
      :simplified_amacro, :pointer,
      :parameter_0, :double,
      :parameter_1, :double,
      :parameters, :double, FFI::Type::FLOAT.size * 102, # APERTURE_PARAMETERS_MAX
      :nuf_parameters, :int,
      :unit, :int
  end
end