require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe RSolr::Direct do
  
  context 'initialization' do
    
    it 'should modifiy RSolr' do
      RSolr.should respond_to(:direct_connect)
    end
    
    it 'should not change the default connect behavior' do
      RSolr.connect.connection.should be_a(RSolr::Connection)
    end
    
    it 'should attempt to use a direct connect if :solr_home is set but raise a MissingRequiredJavaLibs' do
      lambda{
        RSolr.direct_connect(nil)
      }.should raise_error(RSolr::Direct::Connection::MissingRequiredJavaLibs)
    end
    
    it 'should attempt to use a direct connect if :solr_home is set but raise a InvalidSolrHome' do
      load_required_java_libs
      lambda{
        RSolr.direct_connect(:solr_home=>'')
      }.should raise_error(RSolr::Direct::Connection::InvalidSolrHome)
    end
    
    it 'should create direct connection succesfully' do
      load_required_java_libs
      RSolr.direct_connect(:solr_home=>solr_home_dir).connection.should be_a(RSolr::Direct::Connection)
    end
    
    it 'should accept a Java::OrgApacheSolrCore::SolrCore' do
      load_required_java_libs
      core = new_solr_core solr_home_dir, solr_data_dir
      rsolr = RSolr.direct_connect(core)
      rsolr.should be_a(RSolr::Client)
      rsolr.connection.should be_a(RSolr::Direct::Connection)
      core.close
    end
    
    it 'should accept a Java::OrgApacheSolrServlet::DirectSolrConnection' do
      load_required_java_libs
      dc = new_direct_solr_connection solr_home_dir, solr_data_dir
      rsolr = RSolr.direct_connect(dc)
      rsolr.should be_a(RSolr::Client)
      rsolr.connection.should be_a(RSolr::Direct::Connection)
      dc.close
    end
    
  end
  
  module ConnectionHelpers
    
    def self.included base
      base.let(:connections){
        [
          RSolr.direct_connect(:solr_home=>solr_home_dir),
          RSolr.direct_connect(new_solr_core(solr_home_dir, solr_data_dir)),
          RSolr.direct_connect(new_direct_solr_connection(solr_home_dir, solr_data_dir))
        ]
      }
    end
    
  end
  
  context 'connection closing' do
    
    include ConnectionHelpers
    
    it '(they) should have connection objects that respond to close, and set the internal "direct" attribute to nil' do
      connections.each do |rsolr|
        rsolr.connection.direct # <- connect
        rsolr.connection.instance_variable_get("@direct").should_not be(nil)
        rsolr.connection.close
        rsolr.connection.instance_variable_get("@direct").should be(nil)
      end
    end
    
    it 'should automatically close when using the block style of connecting' do
      rsolr = nil
      RSolr.direct_connect(:solr_home => solr_home_dir) do |client|
        rsolr = client
        client.connection.direct # <- connect
        rsolr.connection.instance_variable_get("@direct").should_not be(nil)
      end
      rsolr.connection.instance_variable_get("@direct").should be(nil)
    end
    
  end
  
  context 'querying' do
    
    include ConnectionHelpers
    
    it '(they) should return a solr response hash when calling select' do
      connections.each do |rsolr|
        response = rsolr.select(:params => {:q => '*:*'})
        response.should be_a(Hash)
        response.keys.should include("response", "responseHeader")
        rsolr.connection.close
      end
    end
    
  end
  
end