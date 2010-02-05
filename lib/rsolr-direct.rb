require 'java'
require 'rubygems'
require 'rsolr'

#
# Connection for JRuby + DirectSolrConnection
#
module RSolr::Direct
  
  module Connectable
    
    # load the java libs that ship with rsolr-direct
    # RSolr.load_java_libs
    # rsolr = RSolr.connect :direct, :solr_home => ''
    def load_java_libs
      @java_libs_loaded ||= (
        base_dir = File.expand_path(File.join(File.dirname(__FILE__), '..', 'solr'))
        ['lib', 'dist'].each do |sub|
          Dir[File.join(base_dir, sub, '*.jar')].each do |jar|
            require jar
          end
        end
        true
      )
    end
    
    # RSolr.connect :direct, :solr_home => 'apache-solr/example/solr'
    # RSolr.connect :direct, java_solr_core
    # RSolr.connect :direct, java_direct_solr_connection
    def connect *args, &blk
      if args.first == :direct
        client = RSolr::Client.new RSolr::Direct::Connection.new(*args[1..-1])
        if block_given?
          yield client
          client.connection.close
          nil
        else
          client
        end
      else
        # use the original connect method
        super *args, &blk
      end
    end
    
  end
  
  RSolr.extend RSolr::Direct::Connectable
  
  class Connection
    
    include RSolr::Connection::Requestable
    
    attr_accessor :opts
    
    class MissingRequiredJavaLibs < RuntimeError
    end
    
    class InvalidSolrHome < RuntimeError
    end
    
    # opts can be an instance of org.apache.solr.servlet.DirectSolrConnection
    # if opts is NOT an instance of org.apache.solr.servlet.DirectSolrConnection
    # then...
    # required: opts[:solr_home] is absolute path to solr home (the directory with "data", "config" etc.)
    def initialize opts
      
      begin
        org.apache.solr.servlet.DirectSolrConnection
      rescue NameError
        raise MissingRequiredJavaLibs
      end
      
      if opts.is_a?(Hash) and opts[:solr_home]
        raise InvalidSolrHome unless File.exists?(opts[:solr_home])
        opts[:data_dir] ||= File.join(opts[:solr_home], 'data')
        @opts = opts
      elsif opts.class.to_s == "Java::OrgApacheSolrCore::SolrCore"
        @direct = org.apache.solr.servlet.DirectSolrConnection.new(opts)
      elsif opts.class.to_s == "Java::OrgApacheSolrServlet::DirectSolrConnection"
        @direct = opts
      end
    end
    
    # sets the @direct instance variable if it has not yet been set
    def direct
      @direct ||= org.apache.solr.servlet.DirectSolrConnection.new(opts[:solr_home], @opts[:data_dir], nil)
    end
    
    def close
      if @direct
        @direct.close
        puts "CLOSING -> #{@direct}"
        @direct = nil
      end
    end
    
    # send a request to the connection
    # request '/select', :q=>'something'
    # request '/update', :wt=>:xml, '</commit>'
    def request(path, params={}, data=nil, opts={})
      data = data.to_xml if data.respond_to?(:to_xml)
      url = build_url(path, params)
      begin
        body = direct.request(url, data)
      rescue
        raise RSolr::RequestError.new($!.message)
      end
      {
        :status_code => 200,
        :url=>url,
        :body=>body,
        :path=>path,
        :params=>params,
        :data=>data,
        :headers => {},
        :message => ''
      }
    end
    
  end
  
end