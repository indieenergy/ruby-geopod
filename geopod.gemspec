# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{geopod}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Indie Energy Systems"]
  s.date = %q{2011-04-22}
  s.description = %q{A client for the Indie Energy Systems Geopod API}
  s.email = %q{software@indieenergy.com}
  s.extra_rdoc_files = ["lib/geopod.rb"]
  s.files = ["Manifest", "Rakefile", "geopod.gemspec", "lib/geopod.rb"]
  s.homepage = %q{http://geopod.github.com/geopod/}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Geopod"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{geopod}
  s.rubygems_version = %q{1.7.2}
  s.summary = %q{A client for the Indie Energy Systems Geopod API}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json>, [">= 0"])
      s.add_runtime_dependency(%q<oauth>, [">= 0"])
    else
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<oauth>, [">= 0"])
    end
  else
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<oauth>, [">= 0"])
  end
end
