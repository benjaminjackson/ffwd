# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "ffwd"

require "minitest/autorun"
require "minitest/stub_any_instance"

# Fixture loading helper
module FixtureHelper
  def fixture_path(filename)
    File.join(__dir__, "fixtures", filename)
  end

  def load_fixture(filename)
    File.read(fixture_path(filename))
  end
end

class Minitest::Test
  include FixtureHelper
end
