require 'zip'
require 'joseph'

rows = 10
columns = 10

# Create new project and load files
project = Joseph::Project.create
Dir.glob('./*.ger').each { |file| project.add_file file, /\.([a-z]+)\.ger/.match(file)[1].to_sym }

# Use boardoutline layer as bounding box
bb = Joseph::RenderSize.from_image(project.file(:boardoutline).image)

# Create panel containing all images
panel = {}
project.index.each { |k, ix| panel[k] = Joseph::Image.create }

# Panelize!
rows.times do |row|
  columns.times do |col|
    transform = Joseph::UserTransformation.new
    transform[:translate_x] = bb.width * col
    transform[:translate_y] = bb.height * row

    panel.each do |k, image|
      image.add project.file(k).image, transform
    end
  end
end

# Build ZIP as output format
io = Zip::File.open('./panel.zip', Zip::File::CREATE)
panel.each do |k, image|
  io.get_output_stream("panel.#{k}.ger") { |f| f.puts(image.to_output.data) }
end
io.close