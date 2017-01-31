require 'spec_helper'

# Most specs are using the bridge class, thus binding spec itself is quite empty
describe Bridge do
  it 'should create a new gerbv project' do
    project = Bridge.gerbv_create_project
    expect(project).to be_a(Project)
  end

end