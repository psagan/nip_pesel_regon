# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nip_pesel_regon/version'

Gem::Specification.new do |spec|
  spec.name          = "nip_pesel_regon"
  spec.version       = NipPeselRegon::VERSION
  spec.authors       = ["Patryk Sagan"]
  spec.email         = ["patryk.sagan@icloud.com"]

  spec.summary       = %q{NIP, PESEL, REGON validator for Ruby, Rails}
  spec.description   = %q{Validates polish identification numbers NIP, PESEL, REGON. Can be used in any ruby script or integrated with Rails validation}
  spec.homepage      = "https://github.com/psagan/nip_pesel_regon"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "supermodel", "~> 0.1", ">= 0.1.6"
  spec.add_development_dependency "activesupport", "~> 3.0.0"
end
