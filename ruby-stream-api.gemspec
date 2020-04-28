require_relative 'lib/version.rb'

Gem::Specification.new do |spec|
  spec.name          = "ruby-stream-api"
  spec.version       = Stream::VERSION
  spec.authors       = ["amihaiemil"]
  spec.email         = ["amihaiemil@gmail.com"]

  spec.summary       = "Ruby Stream API"
  spec.description   = "Stream API for Ruby, inspired by Java 8's Stream API"
  spec.homepage      = "https://github.com/ruby-ee/ruby-stream-api"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ruby-ee/ruby-stream-api"
  spec.metadata["changelog_uri"] = "https://github.com/ruby-ee/ruby-stream-api"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
