# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "active_sms/backend/smsru/version"

Gem::Specification.new do |spec|
  spec.name          = "active_sms-backend-smsru"
  spec.version       = ActiveSMS::Backend::Smsru::VERSION
  spec.authors       = ["Fedcomp"]
  spec.email         = ["aglergen@gmail.com"]

  spec.summary       = "ActiveSMS backend for sms.ru service"
  spec.homepage      = "https://github.com/Fedcomp/active_sms-backend-smsru"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org.
  # To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`
                       .split("\x0")
                       .reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # TODO: Activate when active_sms will be published
  # spec.add_dependency "active_sms"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
