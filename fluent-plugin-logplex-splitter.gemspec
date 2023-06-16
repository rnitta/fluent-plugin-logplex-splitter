lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name    = "fluent-plugin-logplex-splitter"
  spec.version = "0.1.0"
  spec.authors = ["rnitta"]
  spec.email   = ["attinyes@gmail.com"]

  spec.summary       = %q{fluentd output plugin to process logplex http log drain}
  spec.description   = %q{that is it}
  spec.license       = "Apache-2.0"

  test_files, files  = `git ls-files -z`.split("\x0").partition do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.files         = files
  spec.executables   = files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = test_files
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.1.4"
  spec.add_development_dependency "rake", "~> 13.0.6"
  spec.add_development_dependency "test-unit", "~> 3.3.4"
  spec.add_runtime_dependency "fluentd", [">= 0.14.10", "< 2"]
  spec.add_runtime_dependency 'fluent-mixin-config-placeholders', '>= 0.3.0'
  spec.add_runtime_dependency 'fluent-mixin-rewrite-tag-name'
end
