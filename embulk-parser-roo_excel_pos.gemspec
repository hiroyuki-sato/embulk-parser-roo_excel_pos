
Gem::Specification.new do |spec|
  spec.name          = "embulk-parser-roo_excel_pos"
  spec.version       = "0.1.0"
  spec.authors       = ["Hiroyuki Sato"]
  spec.summary       = "Roo Excel With Position"
  spec.description   = "Parses Excel data from specific position."
  spec.email         = ["hiroysato@gmail.com"]
  spec.licenses      = ["MIT"]
  # TODO set this: spec.homepage      = "https://github.com/hsato/embulk-parser-roo_excel_pos"

  spec.files         = `git ls-files`.split("\n") + Dir["classpath/*.jar"]
  spec.test_files    = spec.files.grep(%r{^(test|spec)/})
  spec.require_paths = ["lib"]

  #spec.add_dependency 'YOUR_GEM_DEPENDENCY', ['~> YOUR_GEM_DEPENDENCY_VERSION']
  spec.add_development_dependency 'embulk', ['>= 0.8.13']
  spec.add_development_dependency 'bundler', ['>= 1.10.6']
  spec.add_development_dependency 'rake', ['>= 10.0']
  spec.add_dependency 'roo', ['~> 2.5.0']
end
