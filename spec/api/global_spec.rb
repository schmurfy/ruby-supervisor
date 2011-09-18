require File.expand_path('../../spec_helper', __FILE__)
require File.expand_path('../../../lib/ruby-supervisor/api', __FILE__)

describe 'Global API' do
  before do
    @server = stub('XMLRPC::Client', :call => nil)
    XMLRPC::Client.stubs(:new2).returns(@server)
    RubySupervisor::Client.any_instance.stubs(:check_api_version)
    @client = RubySupervisor::Client.new
  end
  
  it 'should return api version' do
    @client.expects(:request).with('getAPIVersion').returns('3.0')
    @client.api_version.should == "3.0"
  end
  
  it 'should return supervisor version' do
    @client.expects(:request).with('getSupervisorVersion').returns('1.0')
    @client.version.should == '1.0'
  end
  
  it 'should return its identification' do
    @client.expects(:request).with('getIdentification').returns('supervisor')
    @client.identifier.should == 'supervisor'
  end
  
  it 'should return its PID' do
    @client.expects(:request).with('getPID').returns(340)
    @client.pid.should == 340
  end
  
  it 'should return its state' do
    @client.expects(:request).with('getState').returns('statecode' => 1)
    @client.state.should == :running
  end
  
  it 'should returns process state' do
    @client.expects(:request).with('getAllProcessesInfo').returns([])
    @client.processes.should == []
  end
  
  it 'can start all processes' do
    @client.expects(:request).with('startAllProcesses', false)
    @client.start_processes(false)
  end
  
  it 'can stop all processes' do
    @client.expects(:request).with('stopAllProcesses', false)
    @client.stop_processes(false)
  end
  
  it 'can clear all processes logs' do
    @client.expects(:request).with('clearAllProcessesLogs')
    @client.clear_processes_logs()
  end
  
  it 'can read supervisor logs' do
    @client.expects(:request).with('readLog', 1, 45)
    @client.read_log(1, 45)
  end
  
  it 'can clear supervisor logs' do
    @client.expects(:request).with('clearLog')
    @client.clear_log()
  end
  
  it 'can restart supervisor process' do
    @client.expects(:request).with('restart')
    @client.restart()
  end
  
  it 'can shutdown supervisor process' do
    @client.expects(:request).with('shutdown')
    @client.shutdown()
  end
  
  it 'can send remote comm event' do
    @client.expects(:request).with('sendRemoteCommEvent', 1, 23)
    @client.send_remote_comm_event(1, 23)
  end
  
end
