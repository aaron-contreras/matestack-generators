# frozen_string_literal: true

require_relative "lib/matestack_generators/version"

Gem::Specification.new do |spec|
  spec.name = "matestack_generators"
  spec.version = MatestackGenerators::VERSION
  spec.authors = ["Aaron Contreras"]
  spec.email = ["aaronlcaq@gmail.com"]

  spec.summary = "A collection of Ruby on Rails generators to boost your productivity on your Matestack-based app."
  spec.description = "Matestack is an incredible framework. It brings developer happiness back into the equation when working on the full-stack on a Ruby on Rails application. If it wasn't already good enough, this gem brings with it a set of generators - a fantastic feature of Rails applicactions - in order to boost your productivity while working on Matestack and multiplying the developer-happiness effect we all love."
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
