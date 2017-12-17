require "test_helper"


class Marvel::ApiTest < Minitest::Test
  def test_configuration_is_correct
    assert Marvel::Api
  end

  def test_that_it_has_a_version_number
    refute_nil ::Marvel::Api::VERSION
  end

  
end
