require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe RSolr::Direct do
  
  context 'RSolr mixin' do
    it 'should attach a direct_connect method to RSolr' do
      RSolr.should respond_to(:direct_connect)
    end
  end
  
  context 'initialization' do
    
    it 'should raise a MissingRequiredJavaLibs if the required java libs are not available' do
      lambda{
        RSolr.direct_connect
      }.should raise_error(RSolr::Direct::Connection::MissingRequiredJavaLibs)
    end
    
    it 'should not raise a MissingRequiredJavaLibs if the required java libs are available' do
      load_required_java_libs
      lambda{
        RSolr.direct_connect
      }.should_not raise_error(RSolr::Direct::Connection::MissingRequiredJavaLibs)
    end
    
    it 'should raise an InvalidSolrHome if :solr_home is not valid' do
      load_required_java_libs
      lambda{
        RSolr.direct_connect
      }.should raise_error(RSolr::Direct::Connection::InvalidSolrHome)
    end
    
    it 'should not raise an InvalidSolrHome if :solr_home is valid' do
      load_required_java_libs
      lambda{
        RSolr.direct_connect(:solr_home => solr_home_dir)
      }.should_not raise_error(RSolr::Direct::Connection::InvalidSolrHome)
    end
    
  end
  
end