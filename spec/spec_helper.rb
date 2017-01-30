require 'digest/md5'
require 'chunky_png'
require 'benchmark'

require 'joseph'
include Joseph

RSpec::Matchers.define(:be_same_image_as) do |expected_data|
  match do |actual_data|
    actual = ChunkyPNG::Datastream.from_blob actual_data
    expected = ChunkyPNG::Datastream.from_blob expected_data

    Digest::MD5.hexdigest(actual.imagedata) == Digest::MD5.hexdigest(expected.imagedata)
  end
end
