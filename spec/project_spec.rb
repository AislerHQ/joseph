require 'spec_helper'

describe Project do
  it 'should create a new project and add a file' do
    project = Project.create
    expect(project).to be_a(Project)

    project.add_file('./spec/assets/3_hat.toplayer.ger', :toplayer)
    expect(project.index[:toplayer]).to be_truthy
    expect(project.file(:toplayer)).to be_a(FileInfo)
    expect(project.file(:bottomlayer)).to be_falsey
  end

  it 'should export a project to PNG' do
    project = Project.create
    project.add_file('./spec/assets/3_hat.toplayer.ger', :toplayer)

    output = project.to_png
    expect(output.data).to be_same_image_as(IO.read('./spec/results/toplayer_as_png.png'))
  end

  it 'should export a project mirrored with bounding box to PNG' do
    project = Project.create
    project.add_file('./spec/assets/3_hat.bottomlayer.ger', :bottomlayer)
    project.file(0)[:transform][:mirror_around_y] = 1

    output = project.to_png(mirror: true, bb: RenderSize.from_image(project.file(0).image))
    expect(output.data).to be_same_image_as(IO.read('./spec/results/bottomlayer_mirrored.png'))
  end

end