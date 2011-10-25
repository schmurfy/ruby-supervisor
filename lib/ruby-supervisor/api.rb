require 'xmlrpc/client'
require File.expand_path('../api/global', __FILE__)
require File.expand_path('../api/process', __FILE__)
require File.expand_path('../api/process_logs', __FILE__)
require File.expand_path('../api/process_group', __FILE__)


module RubySupervisor
  
  ##
  # Main class, one client is connected to one supervisor
  # instance.
  # 
  # @param [String] address network server address
  # @param [Integer] port server port
  # 
  class Client
    
    include ProcessAPI
    include ProcessGroupAPI
    include GlobalAPI
    
    
    def initialize(address = '127.0.0.1', port = 9001, params = {})
      uri = "http://#{address}:#{port}"
      
      params = params.merge(
          :host => address,
          :port => port
        )
      
      @xmlrpc_client = XMLRPC::Client.new3(params)
      check_api_version()
    end
    
    ##
    # Check that the API version is supported.
    # 
    def check_api_version
      v = api_version()
      if v != "3.0"
        raise "unsupported API: #{v}"
      end
    end
    
    
  private
    
    def request(command, *args)
      @xmlrpc_client.call("supervisor.#{command}", *args)
    end
  end
  
end
