require File.expand_path('../../spec_helper', __FILE__)
require File.expand_path('../../../lib/ruby-supervisor/api', __FILE__)

describe 'Process logs API' do
  before do
    @server = stub('XMLRPC::Client', :call => nil)
    XMLRPC::Client.stubs(:new2).returns(@server)
    RubySupervisor::Client.any_instance.stubs(:check_api_version)
    @client = RubySupervisor::Client.new
    @proxy = @client.process('test').logs
  end
  
  it 'can clear logs' do
    @proxy.expects(:request).with('clearProcessLogs', @proxy.name)
    @proxy.clear()
  end
  
  describe 'tail' do
    it 'can tail data from stdout logs' do
      @proxy.expects(:request).with('tailProcessStdoutLog', @proxy.name, 2, 34)
      @proxy.tail(2, 34, :stdout)
    end
    
    it 'can tail data from stderr logs' do
      @proxy.expects(:request).with('tailProcessStderrLog', @proxy.name, 2, 34)
      @proxy.tail(2, 34, :stderr)
    end
    
    it 'should raise an error with invalid parameters' do
      proc{
        @proxy.tail(2, 34, :invalid)
      }.should raise_error
    end
  end
  
  describe 'read' do
    it 'can read data from stdout logs' do
      @proxy.expects(:request).with('readProcessStdoutLog', @proxy.name, 2, 34)
      @proxy.read(2, 34, :stdout)
    end

    it 'can read data from stderr logs' do
      @proxy.expects(:request).with('readProcessStderrLog', @proxy.name, 2, 34)
      @proxy.read(2, 34, :stderr)
    end
    
    it 'should raise an error with invalid parameters' do
      proc{
        @proxy.read(2, 34, :invalid)
      }.should raise_error
    end
  end
  
end
