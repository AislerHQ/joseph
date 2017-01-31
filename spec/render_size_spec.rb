require 'spec_helper'

describe RenderSize do
  it 'should get PCB dimensions' do
    rs = RenderSize.new
    rs[:right] = 10
    rs[:left] = -10
    rs[:top] = 20
    rs[:bottom] = -20
    expect(rs.valid?).to be_truthy
    expect(rs.width).to eq(20)
    expect(rs.height).to eq(40)


    project = Project.create
    project.add_file('./spec/assets/3_hat.boardoutline.ger', :boardoutline)

    rs = RenderSize.from_image(project.file(0).image)
    expect(rs.right).to be_within(0.001).of(2.609)
    expect(rs.left).to be_within(0.001).of(0.05)
    expect(rs.top).to be_within(0.001).of(0.05)
    expect(rs.bottom).to be_within(0.001).of(2.254)
  end

end