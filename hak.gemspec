# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hak/version'

Gem::Specification.new do |spec|
  spec.name          = "hak"
  spec.version       = Hak::VERSION
  spec.authors       = ["jaequery"]
  spec.email         = ["jaequery@gmail.com"]
  spec.summary       = %q{Hak is like NPM for websites}
  spec.description   = %q{Hak is like NPM for websites. You can download, start, and deploy websites directly from the CLI.}
  spec.homepage      = "http://hakberry.com"
  spec.license       = "MIT"
  spec.files = ['lib/hak.rb', 'lib/hak/version.rb']
  spec.executables   = ["hak"]
  spec.add_dependency 'commander', '~> 4.4'
  spec.add_dependency 'colorize'
end
