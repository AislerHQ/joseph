require 'pp'
require 'ffi'
require 'ramdo'

# Apply monkey patches
require 'core_extensions/float/conversions'
require 'core_extensions/integer/conversions'
Float.include CoreExtensions::Float::Conversions
Integer.include CoreExtensions::Integer::Conversions

require 'joseph/gdk_color'
require 'joseph/cirseg'
require 'joseph/render_size'
require 'joseph/render_info'
require 'joseph/net'
require 'joseph/user_transformation'
require 'joseph/aperture'
require 'joseph/knockout'
require 'joseph/step_and_repeat'
require 'joseph/layer'
require 'joseph/image_info'
require 'joseph/image'
require 'joseph/file_info'
require 'joseph/project'
require 'joseph/binding'

module Joseph
end