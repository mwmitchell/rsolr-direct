require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe RSolr::Direct do
  
  context 'initialization' do
    
    it 'should modifiy RSolr' do
      RSolr.should be_a(RSolr::Direct::Connectable)
    end
    
    it 'should not change the default connect behavior' do
      RSolr.connect.connection.should be_a(RSolr::Connection::NetHttp)
    end
    
    it 'should attempt to use a direct connect if :solr_home is set but raise a MissingRequiredJavaLibs' do
      lambda{
        RSolr.connect(:direct, nil)
      }.should raise_error(RSolr::Direct::Connection::MissingRequiredJavaLibs)
    end
    
    it 'should attempt to use a direct connect if :solr_home is set but raise a InvalidSolrHome' do
      load_required_java_libs
      lambda{
        RSolr.connect(:direct, :solr_home=>'')
      }.should raise_error(RSolr::Direct::Connection::InvalidSolrHome)
    end
    
    it 'should create direct connection succesfully' do
      load_required_java_libs
      RSolr.connect(:direct, :solr_home=>solr_home_dir).connection.should be_a(RSolr::Direct::Connection)
    end
    
    it 'should accept a Java::OrgApacheSolrCore::SolrCore' do
      load_required_java_libs
      core = new_solr_core solr_home_dir, solr_data_dir
      rsolr = RSolr.connect(:direct, core)
      rsolr.should be_a(RSolr::Client)
      rsolr.connection.should be_a(RSolr::Direct::Connection)
      core.close
    end
    
    it 'should accept a Java::OrgApacheSolrServlet::DirectSolrConnection' do
      load_required_java_libs
      dc = new_direct_solr_connection solr_home_dir, solr_data_dir
      rsolr = RSolr.connect(:direct, dc)
      rsolr.should be_a(RSolr::Client)
      rsolr.connection.should be_a(RSolr::Direct::Connection)
      dc.close
    end
    
  end
  
end