module Joseph
  class Project < FFI::Struct
    def self.create(r = 0x00, g = 0x00, b = 0x00)
      project = Bridge.gerbv_create_project
      project[:background].red = r
      project[:background].green = g
      project[:background].blue = b
      project
    end

    attr_reader :index

    layout :background, GdkColor.by_value,
      :max_files, :int,
      :file, :pointer,
      :curr_index, :int,
      :last_loaded, :int,
      :render_type, :int,
      :check_before_delete, :bool,
      :path, :string,
      :execpath, :string,
      :execname, :string,
      :project, :string

    def initialize(address)
      super(address)
      @index = Hash.new
    end

    def file(ix)
      ix = @index[ix] if ix.is_a? Symbol
      return nil if ix.nil? || ix > self[:last_loaded]

      FileInfo.new((self[:file] + (ix * FFI::Type::POINTER.size)).read_pointer)
    end

    def add_file(file, name, color = {})
      file = file.file if file.is_a? Ramdo::Store
      [:red, :green, :blue, :alpha].each { |k, v| color[k] ||= 0xFF.to_gdk_color }

      last_ix = self[:last_loaded]
      Bridge.gerbv_open_layer_from_filename_with_color(self, file, color[:red], color[:green], color[:blue], color[:alpha])
      return false if self[:last_loaded] == last_ix # Return if file is invalid

      @index[name] = self[:last_loaded]
    end

    def each_file(&block)
      0.upto(self[:last_loaded]) do |ix|
        file = FileInfo.new((self[:file] + (ix * FFI::Type::POINTER.size)).read_pointer)
        yield(file)
      end
    end

    def to_png(args = {})
      store = args[:store] || Ramdo::Store.new
      dpi = args[:dpi] || 600 # HiDPI setting for high resolution screens

      if args[:bb] && args[:bb].valid?
        Bridge.gerbv_export_png_file_from_project(self, render_info(args[:bb], dpi, !!args[:mirror]), store.file)
      else
        Bridge.gerbv_export_png_file_from_project_autoscaled(self, 1920, 1080, store.file)
      end

      store
    end

    def destroy!
      Bridge.gerbv_destroy_project(self)
    end

    private
    def render_info(bb, dpi, mirror)
      info = RenderInfo.new
      info[:render_type] = 3

      info[:display_width] = dpi * bb.width
      info[:display_height] = dpi * bb.height
      info[:scale_factor_x] = dpi
      info[:scale_factor_y] = dpi
      info[:lower_left_x] = mirror ? -bb.right : bb.left
      info[:lower_left_y] = bb.top

      info
    end
  end
end
