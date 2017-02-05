require 'fileutils'
require 'joseph'

# Create new project and load files
project = Joseph::Project.create
Dir.glob('./gerbers/*.ger').each { |file| project.add_file file, /\.([a-z]+)\.ger/.match(file)[1].to_sym }

# Use boardoutline layer as bounding box
bb = Joseph::RenderSize.from_image(project.file(:boardoutline).image)

fiducials = []
spacing = 0.05
diameter_copper = 0.03
diameter_soldermask = 0.05
# Copper layer
fiducials << { x: bb[:left] - spacing, y: bb[:bottom] + spacing, d: diameter_copper, layer: :toplayer }
fiducials << { x: bb[:right] + spacing, y: bb[:top] - spacing, d: diameter_copper, layer: :toplayer }
fiducials << { x: bb[:left] - spacing, y: bb[:top] - spacing, d: diameter_copper, layer: :toplayer }
# Soldermask layer
fiducials << { x: bb[:left] - spacing, y: bb[:bottom] + spacing, d: diameter_soldermask, layer: :topsoldermask }
fiducials << { x: bb[:right] + spacing, y: bb[:top] - spacing, d: diameter_soldermask, layer: :topsoldermask }
fiducials << { x: bb[:left] - spacing, y: bb[:top] - spacing, d: diameter_soldermask, layer: :topsoldermask }

fiducials.each do |fid|
  Joseph::Bridge.gerbv_image_create_line_object(project.file(fid[:layer]).image, fid[:x], fid[:y], fid[:x], fid[:y], fid[:d], :circle)
end

# Save output files
project.index.each do |k, ix|
  FileUtils.cp(project.file(ix).image.to_output.file, "with_fiducial.#{k}.ger")
end
