require "test_helper"

class Stream::ApiTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Stream::VERSION
  end
end
