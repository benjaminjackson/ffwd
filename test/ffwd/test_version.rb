# frozen_string_literal: true

require "test_helper"

module Ffwd
  class TestVersion < Minitest::Test
    def test_version_constant_exists
      refute_nil Ffwd::VERSION
    end

    def test_version_is_semver_format
      assert_match(/\A\d+\.\d+\.\d+\z/, Ffwd::VERSION)
    end

    def test_version_is_0_1_0
      assert_equal "0.1.0", Ffwd::VERSION
    end
  end
end
