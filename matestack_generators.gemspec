# frozen_string_literal: true

require_relative "lib/matestack_generators/version"

Gem::Specification.new do |spec|
  spec.name = "matestack_generators"
  spec.version = MatestackGenerators::VERSION
  spec.authors = ["Aaron Contreras"]
  spec.email = ["aaronlcaq@gmail.com"]

  spec.summary = "Write a short summary, because RubyGems requires one."
  spec.description = "Write a longer description or delete this line."
  spec.homepage = "https://docs.matestack.io"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.2"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/aaron-contreras/matestack-generators"
  spec.metadata["changelog_uri"] = "https://github.com/aaron-contreras/matestack-generators/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "rails", "~> 6.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
