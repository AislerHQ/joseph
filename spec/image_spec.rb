require 'spec_helper'

describe Project do
  it 'should draw primitives on a new image' do
    image = Image.create
    expect(image.net_count).to eq(0)

    Bridge.gerbv_image_create_line_object(image, 0, 0, 10, 10, 0.0, :circle)
    Bridge.gerbv_image_create_line_object(image, 0, 0, 0, 10, 0.1, :circle)
    Bridge.gerbv_image_create_rectangle_object(image, 5, 0, 1, 1)
    Bridge.gerbv_image_create_arc_object(image, 0, 5, 1, 0, 360, 0.0, :circle)
    expect(image.net_count).to eq(7)

    output = image.to_output
    expect(Digest::SHA1.hexdigest(output.data)).to eq('5151086a6458b7ead0d6e023bbdcd89d6382fcad')

    image.destroy!
  end


  it 'should copy one image into another' do
    project = Project.create
    project.add_file('./spec/assets/3_hat.toplayer.ger', :toplayer)

    source = project.file(:toplayer).image
    destination = Image.create

    expect(source.net_count).to eq(2235)
    expect(destination.net_count).to eq(0)

    destination.add source
    expect(destination.net_count).to eq(2235)

    t = Benchmark.realtime do
      200.times { |i| destination.add source }
    end
    expect(t).to be <= 5
  end

  it 'should combine silkscreen' do
    project = Project.create
    project.add_file './spec/assets/vesc-capbank.topsilkscreen.ger', :topsilkscreen
    project.add_file './spec/assets/vesc-capbank.topsilkscreen.ger', :topsilkscreen

    image = Image.create
    image.add(project.file(0).image)

    transform = UserTransformation.new
    transform[:translate_x] = 2
    image.add(project.file(1).image, transform)


    output = image.to_output
    expect(Digest::SHA1.hexdigest(output.data)).to eq('6eee0d137fa6c089a1c82a03fcc567cbbe06c1eb')
  end


end