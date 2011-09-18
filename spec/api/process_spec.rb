require File.expand_path('../../spec_helper', __FILE__)
require File.expand_path('../../../lib/ruby-supervisor/api', __FILE__)

describe 'Process API' do
  before do
    @server = stub('XMLRPC::Client', :call => nil)
    XMLRPC::Client.stubs(:new2).returns(@server)
    RubySupervisor::Client.any_instance.stubs(:check_api_version)
    @client = RubySupervisor::Client.new
    @proxy = @client.process('test')
  end
  
  it 'should return the process state' do
    @proxy.expects(:request).with('getProcessInfo', @proxy.name).returns('state' => 30)
    @proxy.state.should == :backoff
  end
   
  it 'should return a ProcessProxy' do
    @proxy.should be_a(RubySupervisor::ProcessProxy)
  end
  
  it 'can retrieve process infos' do
    @client.expects(:request).with('getProcessInfo', @proxy.name)
    @proxy.infos()
  end
  
  it 'can start process' do
    @client.expects(:request).with('startProcess', @proxy.name, true)
    @proxy.start()
  end
  
  it 'can stop process' do
    @client.expects(:request).with('stopProcess', @proxy.name, true)
    @proxy.stop()
  end
  
  it 'can restart process' do
    @client.expects(:request).with('stopProcess', @proxy.name, true)
    @client.expects(:request).with('startProcess', @proxy.name, true)
    @proxy.restart()
  end
  
  it 'can write data to process standard input' do
    @client.expects(:request).with('sendProcessStdin', @proxy.name, 'something')
    @proxy.send_stdin('something')
  end
  
end
