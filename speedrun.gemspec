# frozen_string_literal: true

require_relative "lib/speedrun/version"

Gem::Specification.new do |spec|
  spec.name = "speedrun"
  spec.version = Speedrun::VERSION
  spec.authors = ["Benjamin Jackson"]
  spec.email = ["ben@hearmeout.co"]

  spec.summary = "Detect and remove freeze/low-motion regions from videos"
  spec.description = "CLI tool that uses ffmpeg to automatically detect frozen or low-motion segments in videos and remove them, stitching together the active parts."
  spec.homepage = "https://github.com/benjaminjackson/speedrun"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["source_code_uri"] = "https://github.com/benjaminjackson/speedrun"
  spec.metadata["changelog_uri"] = "https://github.com/benjaminjackson/speedrun/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore test/])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Runtime dependencies
  spec.add_dependency "thor", "~> 1.3"
  spec.add_dependency "ruby-progressbar", "~> 1.13"
  spec.add_dependency "pastel", "~> 0.8"

  # Development dependencies
  spec.add_development_dependency "guard", "~> 2.18"
  spec.add_development_dependency "guard-minitest", "~> 2.4"
  spec.add_development_dependency "minitest-stub_any_instance", "~> 1.0"
end
