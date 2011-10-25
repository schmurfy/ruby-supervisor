require File.expand_path('../spec_helper', __FILE__)
require File.expand_path('../../lib/ruby-supervisor/api', __FILE__)

describe 'API client' do
  before do
    @server = stub('XMLRPC::Client', :call => nil)
    XMLRPC::Client.stubs(:new3).returns(@server)
  end
  
  it 'should check api version on connect' do
    @server.expects(:call).with('supervisor.getAPIVersion').returns('3.0')
    @client = RubySupervisor::Client.new
  end
  
  it 'should raise an error on invalid api version' do
    @server.expects(:call).with('supervisor.getAPIVersion').returns('2.0')
    proc{
      @client = RubySupervisor::Client.new
    }.should raise_error
  end
  
end
