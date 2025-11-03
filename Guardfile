# frozen_string_literal: true

guard :minitest, autorun: false do
  # Watch lib files and run all tests
  watch(%r{^lib/(.+)\.rb$}) { 'test' }

  # Watch test files and run corresponding test
  watch(%r{^test/test_(.+)\.rb$})
  watch(%r{^test/ffwd/test_(.+)\.rb$})

  # Watch test_helper and run all tests
  watch(%r{^test/test_helper\.rb$}) { 'test' }
  watch(%r{^test/support/.+\.rb$}) { 'test' }
end
