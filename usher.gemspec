# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{usher}
  s.version = "0.6.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Daniel Neighman", "Daniel Vartanov", "Jakub \305\240\305\245astn\303\275", "Joshua Hull"]
  s.date = %q{2010-01-05}
  s.description = %q{A general purpose routing library}
  s.email = %q{joshbuddy@gmail.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "History.txt",
    "Manifest.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION.yml",
    "lib/usher.rb",
    "lib/usher/delimiters.rb",
    "lib/usher/exceptions.rb",
    "lib/usher/grapher.rb",
    "lib/usher/interface.rb",
    "lib/usher/interface/email.rb",
    "lib/usher/interface/merb.rb",
    "lib/usher/interface/rack.rb",
    "lib/usher/interface/rack/mapper.rb",
    "lib/usher/interface/rack/route.rb",
    "lib/usher/interface/rails20.rb",
    "lib/usher/interface/rails22.rb",
    "lib/usher/interface/rails22/mapper.rb",
    "lib/usher/interface/rails23.rb",
    "lib/usher/interface/rails23/mapper.rb",
    "lib/usher/interface/rails3.rb",
    "lib/usher/interface/sinatra.rb",
    "lib/usher/interface/text.rb",
    "lib/usher/node.rb",
    "lib/usher/route.rb",
    "lib/usher/route/path.rb",
    "lib/usher/route/request_method.rb",
    "lib/usher/route/static.rb",
    "lib/usher/route/util.rb",
    "lib/usher/route/variable.rb",
    "lib/usher/splitter.rb",
    "lib/usher/util.rb",
    "lib/usher/util/generate.rb",
    "lib/usher/util/graph.rb",
    "lib/usher/util/parser.rb",
    "lib/usher/util/rack-mixins.rb",
    "rails/init.rb",
    "spec/private/delimiters_spec.rb",
    "spec/private/destination_spec.rb",
    "spec/private/email/recognize_spec.rb",
    "spec/private/generate_spec.rb",
    "spec/private/generate_with_spec.rb",
    "spec/private/grapher_spec.rb",
    "spec/private/parser_spec.rb",
    "spec/private/path_spec.rb",
    "spec/private/rack/dispatch_spec.rb",
    "spec/private/rack/generate_spec.rb",
    "spec/private/rack/route_spec.rb",
    "spec/private/rails2_2/compat.rb",
    "spec/private/rails2_2/generate_spec.rb",
    "spec/private/rails2_2/path_spec.rb",
    "spec/private/rails2_2/recognize_spec.rb",
    "spec/private/rails2_3/compat.rb",
    "spec/private/rails2_3/generate_spec.rb",
    "spec/private/rails2_3/path_spec.rb",
    "spec/private/rails2_3/recognize_spec.rb",
    "spec/private/recognize_spec.rb",
    "spec/private/request_method_spec.rb",
    "spec/private/splitter_spec.rb",
    "spec/private/url_parts_spec.rb",
    "spec/spec.opts",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/joshbuddy/usher}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{joshbuddy-usher}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{A general purpose routing library}
  s.test_files = [
    "spec/private/delimiters_spec.rb",
    "spec/private/destination_spec.rb",
    "spec/private/email/recognize_spec.rb",
    "spec/private/generate_spec.rb",
    "spec/private/generate_with_spec.rb",
    "spec/private/grapher_spec.rb",
    "spec/private/parser_spec.rb",
    "spec/private/path_spec.rb",
    "spec/private/rack/dispatch_spec.rb",
    "spec/private/rack/generate_spec.rb",
    "spec/private/rack/route_spec.rb",
    "spec/private/rails2_2/compat.rb",
    "spec/private/rails2_2/generate_spec.rb",
    "spec/private/rails2_2/path_spec.rb",
    "spec/private/rails2_2/recognize_spec.rb",
    "spec/private/rails2_3/compat.rb",
    "spec/private/rails2_3/generate_spec.rb",
    "spec/private/rails2_3/path_spec.rb",
    "spec/private/rails2_3/recognize_spec.rb",
    "spec/private/recognize_spec.rb",
    "spec/private/request_method_spec.rb",
    "spec/private/splitter_spec.rb",
    "spec/private/url_parts_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<fuzzyhash>, [">= 0.0.11"])
    else
      s.add_dependency(%q<fuzzyhash>, [">= 0.0.11"])
    end
  else
    s.add_dependency(%q<fuzzyhash>, [">= 0.0.11"])
  end
end

