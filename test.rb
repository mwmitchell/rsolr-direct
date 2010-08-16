require "rubygems"
require "rsolr"
require "lib/rsolr-direct.rb"

RSolr::Direct.load_java_libs

RSolr.direct_connect(:solr_home => File.expand_path("./solr/example/solr")) do |solr|
  response = solr.select(:params => {:q => "*:*"})
  puts response.inspect
end