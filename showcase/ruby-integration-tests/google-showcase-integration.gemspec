# -*- ruby -*-
# encoding: utf-8

Gem::Specification.new do |gem|
  gem.name          = "google-showcase-integration"
  gem.version       = "0.1.0"

  gem.authors       = ["Google LLC"]
  gem.email         = "googleapis-packages@google.com"
  gem.description   = "Integration tests for the GAPIC Showcase API"
  gem.summary       = "API Client library for GAPIC Showcase API"
  gem.homepage      = "https://github.com/googleapis/googleapis"
  gem.license       = "Apache-2.0"

  gem.platform      = Gem::Platform::RUBY

  gem.required_ruby_version = ">= 2.0.0"

  gem.add_dependency "google-showcase", "~> 0.1.0"

  gem.add_development_dependency "minitest", "~> 5.10"

end
