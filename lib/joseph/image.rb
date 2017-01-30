module Joseph
  class Image < FFI::Struct
    def self.create
      Bridge.gerbv_create_image nil, nil
    end

    def self.memory_map
      f = {}
      f[:layertype] = :int

      # Ugly as hell but works
      9999.times do |ix|
        sym = "aperture_#{ix}".to_sym
        f[sym] = Aperture.by_ref
      end

      f[:layers] = :pointer
      f[:states] = :pointer
      f[:amacro] = :pointer
      f[:format] = :pointer
      f[:info] = ImageInfo.by_ref
      f[:netlist] = :pointer
      f[:gerbv_stats] = :pointer
      f[:drill_stats] = :pointer
      f
    end
    layout memory_map


    def add(image, transformation = UserTransformation.new)
      Bridge.gerbv_image_copy_image(image.pointer, transformation.pointer, self.pointer)

      # Check if polarity reset is necessary
      return if image.last_layer[:polarity] == 2
      # As Gerbv does not reset polarity, we add another 'dummy' layer with dark polarity
      # Afterwards a zero flash is created and associated to the new created layer
      # Otherwise some strange memory issue occours when dumping the image

      # Reset polarity of both images
      layer = Bridge.gerbv_image_return_new_layer(last_layer)
      layer[:polarity] = 2 # Default polarity

      each_net do |net|
        if net[:next].null?
          dummy = Bridge.gerber_create_new_net(net, layer, nil)
          dummy[:interpolation] = 8 # Do not draw net / GERBV_INTERPOLATION_DELETED
        end
      end

      nil
    end

    def duplicate(transformation = nil)
      Bridge.gerbv_image_duplicate_image(self, transformation)
    end

    def to_output(store = Ramdo::Store.new)
      if rs274x?
        Bridge.gerbv_export_rs274x_file_from_image(store.file, self, UserTransformation.new)
      elsif drill?
        Bridge.gerbv_export_drill_file_from_image(store.file, self, UserTransformation.new)
      end

      store
    end

    def each_net(&block)
      address = self[:netlist]
      loop do
        net = Net.new(address)
        yield(net) unless net[:aperture_state] == 0

        # Keep address of next net and return if not available
        address = net[:next]
        break if address.null?
      end
    end

    def net_count
      c = 0
      each_net { c += 1 }
      c
    end

    def last_net
      net = nil
      each_net { |n| net = n }
      net
    end

    def each_layer(&block)
      address = self[:layers]
      loop do
        layer = Layer.new(address)
        yield(layer)

        address = layer[:next]
        break if address.null?
      end
    end

    def layer_count
      c = 0
      each_layer { c += 1 }
      c
    end

    def last_layer
      layer = nil
      each_layer { |l| layer = l }
      layer
    end

    def crop!(bb)
      each_net do |net|
        net[:start_y] = [bb[:bottom], net[:start_y]].min
        net[:stop_y] = [bb[:bottom], net[:stop_y]].min
        net[:start_x] = [bb[:left], net[:start_x]].max
        net[:stop_x] = [bb[:left], net[:stop_x]].max
        net[:start_y] = [bb[:top], net[:start_y]].max
        net[:stop_y] = [bb[:top], net[:stop_y]].max
        net[:start_x] = [bb[:right], net[:start_x]].min
        net[:stop_x] = [bb[:right], net[:stop_x]].min
      end
    end

    def rs274x?
      self[:layertype] == 0
    end

    def drill?
      self[:layertype] == 1
    end

    def info
      self[:info]
    end

    def destroy!
      Bridge.gerbv_destroy_image(self)
    end
  end
end
