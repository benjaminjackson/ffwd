# frozen_string_literal: true

require "test_helper"

module Speedrun
  class TestVersion < Minitest::Test
    def test_version_constant_exists
      refute_nil Speedrun::VERSION
    end

    def test_version_is_semver_format
      assert_match(/\A\d+\.\d+\.\d+\z/, Speedrun::VERSION)
    end

    def test_version_is_0_1_0
      assert_equal "0.1.0", Speedrun::VERSION
    end
  end
end
