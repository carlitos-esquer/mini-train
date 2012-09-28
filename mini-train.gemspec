Gem::Specification.new do |s| 
  s.name = 'mini-train'
  s.version = "0.1.0"
  s.platform = Gem::Platform::RUBY
  s.summary = "An attempt to create a web mini-framework forked from an rack app (rack-golem)"
  s.description = "This is a simplistic web framework"
  s.files = `git ls-files`.split("\n").sort
  s.require_path = './lib'
  s.author = "Carlos Esquer"
  s.email = "carlitos.esquer@gmail.com"
  s.homepage = "http://rubymx.blogspot.com"
  s.add_dependency(%q<tilt>, [">= 1.2.2"])
  s.add_development_dependency(%q<bacon>, "~> 1.1.0")
end
