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

  it 'should detect if file is invalid' do
    project = Project.create
    expect(project[:last_loaded]).to eq(-1)
    project.add_file './spec/assets/test.EXTREP', :dummy # invalid file with invalid extension
    expect(project[:last_loaded]).to eq(-1)
    project.add_file './spec/assets/test_wrong.GBL', :dummy # invalid file with valid extension
    expect(project[:last_loaded]).to eq(-1)
    expect(project.index.length).to eq(0)
    project.add_file './spec/assets/3_hat.toplayer.ger', :dummy # valid file
    expect(project[:last_loaded]).to eq(0)
    project.add_file './spec/assets/test.EXTREP', :dummy # invalid file with invalid extension
    expect(project[:last_loaded]).to eq(0)
    project.add_file './spec/assets/test_wrong.GBL', :dummy # invalid file with valid extension
    expect(project[:last_loaded]).to eq(0)
    expect(project.index.length).to eq(1)
  end

end