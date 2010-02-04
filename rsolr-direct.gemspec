# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rsolr-direct}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matt Mitchell"]
  s.date = %q{2010-02-04}
  s.description = %q{Provides a non-http connection to your solr/lucene index}
  s.email = %q{goodieboy@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    "LICENSE",
     "README.rdoc",
     "VERSION",
     "lib/rsolr-direct.rb"
  ]
  s.homepage = %q{http://github.com/mwmitchell/rsolr-direct}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{A JRuby, direct connection for RSolr}
  s.test_files = [
    "spec/rsolr-direct_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb",
     "Rakefile",
     "solr/dist/apache-solr-1.4.0.war",
     "solr/dist/apache-solr-cell-1.4.0.jar",
     "solr/dist/apache-solr-clustering-1.4.0.jar",
     "solr/dist/apache-solr-core-1.4.0.jar",
     "solr/dist/apache-solr-dataimporthandler-1.4.0.jar",
     "solr/dist/apache-solr-dataimporthandler-extras-1.4.0.jar",
     "solr/dist/apache-solr-solrj-1.4.0.jar",
     "solr/dist/solrj-lib",
     "solr/lib/commons-codec-1.3.jar",
     "solr/lib/commons-csv-1.0-SNAPSHOT-r609327.jar",
     "solr/lib/commons-fileupload-1.2.1.jar",
     "solr/lib/commons-httpclient-3.1.jar",
     "solr/lib/commons-io-1.4.jar",
     "solr/lib/easymock.jar",
     "solr/lib/geronimo-stax-api_1.0_spec-1.0.1.jar",
     "solr/lib/jcl-over-slf4j-1.5.5.jar",
     "solr/lib/junit-4.3.jar",
     "solr/lib/lucene-analyzers-2.9.1.jar",
     "solr/lib/lucene-core-2.9.1.jar",
     "solr/lib/lucene-highlighter-2.9.1.jar",
     "solr/lib/lucene-memory-2.9.1.jar",
     "solr/lib/lucene-misc-2.9.1.jar",
     "solr/lib/lucene-queries-2.9.1.jar",
     "solr/lib/lucene-snowball-2.9.1.jar",
     "solr/lib/lucene-spellchecker-2.9.1.jar",
     "solr/lib/servlet-api-2.4.jar",
     "solr/lib/slf4j-api-1.5.5.jar",
     "solr/lib/slf4j-jdk14-1.5.5.jar",
     "solr/lib/solr-commons-csv-pom.xml.template",
     "solr/lib/wstx-asl-3.2.7.jar",
     "solr/example/solr/bin",
     "solr/example/solr/conf",
     "solr/example/solr/data",
     "solr/example/solr/README.txt"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_runtime_dependency(%q<rsolr>, [">= 0.12.1"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<rsolr>, [">= 0.12.1"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<rsolr>, [">= 0.12.1"])
  end
end
