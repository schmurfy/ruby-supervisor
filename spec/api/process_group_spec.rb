require File.expand_path('../../spec_helper', __FILE__)
require File.expand_path('../../../lib/ruby-supervisor/api', __FILE__)

describe 'Process group API' do
  before do
    @server = stub('XMLRPC::Client', :call => nil)
    XMLRPC::Client.stubs(:new2).returns(@server)
    RubySupervisor::Client.any_instance.stubs(:check_api_version)
    @client = RubySupervisor::Client.new
    @proxy = @client.group('test')
  end
  
  it 'can start a group' do
    @proxy.expects(:request).with('startProcessGroup', @proxy.name, false)
    @proxy.start(false)
  end
  
  it 'can stop a group' do
    @proxy.expects(:request).with('stopProcessGroup', @proxy.name, false)
    @proxy.stop(false)
  end
  
  it 'can restart a group' do
    @proxy.expects(:request).with('startProcessGroup', @proxy.name, false)
    @proxy.expects(:request).with('stopProcessGroup', @proxy.name, false)
    @proxy.restart(false)
  end
  
end
