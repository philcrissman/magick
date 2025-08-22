# frozen_string_literal: true

require_relative "lib/magick/version"

Gem::Specification.new do |spec|
  spec.name = "magick"
  spec.version = Magick::VERSION
  spec.authors = ["Phil Crissman"]
  spec.email = ["phil.crissman@gmail.com"]

  spec.summary = "A set of functional toys using combinators and lambda calculus."
  spec.homepage = "https://github.com/philcrissman/magick"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/philcrissman/magick"

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

  spec.add_dependency "smullyan", "~> 0.1.4"
end
