# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'selenium-webdriver-full-screenshot/version'

Gem::Specification.new do |spec|
  spec.name          = "selenium-webdriver-full-screenshot"
  spec.version       = Selenium::Webdriver::FullScreenshot::VERSION
  spec.authors       = ["deepriver"]
  spec.email         = ["yoshiyuki.yamada.1984@gmail.com"]

  spec.summary       = "Extended FullScreenshots To Selenium::Webdriver"
  spec.description   = "Extended FullScreenshots To Selenium::Webdriver"
  spec.homepage      = "https://github.com/deepriver/selenium-webdriver-full-screenshot"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency "selenium-webdriver", "~> 3.1.0"
  spec.add_dependency "oily_png", "~> 1.2"
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.10.4"
end
