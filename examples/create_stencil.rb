require 'joseph'

### This example will create a stencil with both top and bottom layer on it.
# As Gerbv does not allow mirroring yet, bottom side is not mirrored
# Spacing between both layers is 10mm
# As this repositiory contains no paste gerber layers soldermask layer is used as example
# Additionally some holes are added to simplify disassembly of top and bottom side

# Create project and add both sides
project = Joseph::Project.create
project.add_file './gerbers/stickipi_hat.topsoldermask.ger', :topsoldermask
project.add_file './gerbers/stickipi_hat.bottomsoldermask.ger', :bottomsoldermask

# Create bounding box
bb = Joseph::RenderSize.from_image(project.file(:topsoldermask).image)

stencil = Joseph::Image.create
# Add top soldermask to stencil
stencil.add project.file(:topsoldermask).image

# Add top soldermask to stencil, mirror and move next to top soldermask
translation = Joseph::UserTransformation.new
translation[:translate_x] = bb.width + 10.0.to_inches
stencil.add project.file(:bottomsoldermask).image, translation

# Draw dotted line to simplify disassembly
x_mid = bb.width + 8.0.to_inches
(0..bb.height.to_i).each do |inch|
  Joseph::Bridge.gerbv_image_create_line_object(stencil, x_mid, inch, x_mid, inch + 0.5, 1.0.to_inches, :circle)
end

# Output gerber file
IO.write('./stencil.ger', stencil.to_output.data)