require 'spec_helper'

# Most specs are using the binding class, thus binding spec itself is quite empty
describe Binding do
  it 'should create a new gerbv project' do
    project = Binding.gerbv_create_project
    expect(project).to be_a(Project)
  end

end