require 'spec_helper'

describe Project, focus: true do
  it 'should create a new project and add a file' do
    project = Project.create
    expect(project).to be_a(Project)

    project.add_file('./spec/assets/3_hat.toplayer.ger', :toplayer)
    expect(project.index[:toplayer]).to be_truthy
    expect(project.file(:toplayer)).to be_a(FileInfo)
    expect(project.file(:bottomlayer)).to be_falsey
  end

  it 'should create a project and export it to PNG' do
    project = Project.create
    project.add_file('./spec/assets/3_hat.toplayer.ger', :toplayer)

    output = project.to_png
    expect(output.data).to be_same_image_as(IO.read('./spec/results/toplayer_as_png.png'))
  end

end