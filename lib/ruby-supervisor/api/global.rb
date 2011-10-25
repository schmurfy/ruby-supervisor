require File.expand_path('../../proxy', __FILE__)

module RubySupervisor  
  
  module GlobalAPI
    
    #
    # returned by get_state
    # 
    STATE_TO_STR = {
         2 => :fatal,
         1 => :running,
         0 => :restarting,
        -1 => :shutdown
      }.freeze
      
    
    ##
    # Return the API Version.
    # 
    # @return [String] API Version
    # 
    def api_version
      request('getAPIVersion')
    end
    
    ##
    # Return supervisor version.
    # 
    # @return [String] Supervisor version
    # 
    def version
      request('getSupervisorVersion')
    end
    
    ##
    # Return supervisor identifying string.
    # Aliased as identifier.
    # 
    # @return [String] identifier
    # 
    def identification
      request('getIdentification')
    end
    alias :identifier :identification
    
    ##
    # Return supervisor pid.
    # 
    # @return [Integer] PID
    # 
    def pid
      request('getPID')
    end
    
    ##
    # Return supervisor current state.
    # 
    # @return [Symbol] Supervisor state
    # 
    def state
      ret = request('getState')
      STATE_TO_STR[ ret['statecode'] ]
    end
    
    ##
    # Return informations for all defined
    # processes.
    # 
    # @return [Array] An array of hash
    # 
    def processes
      request('getAllProcessInfo')
    end
    
    ##
    # Start all processes.
    # 
    # @param [Boolean] wait if true the call will
    #   block until all processes are started.
    # 
    def start_processes(wait = true)
      request('startAllProcesses', wait)
    end
    
    ##
    # Stop all processes.
    # 
    # @param [Boolean] wait if true the call will
    #   block until all processes are stopped.
    #
    def stop_processes(wait = true)
      request('stopAllProcesses', wait)
    end
    
    ##
    # Clear logs for all processes.
    # 
    def clear_processes_logs
      request('clearAllProcessesLogs')
    end
    
    ##
    # Read a chunk of the supervisor logs.
    # 
    # @param [Integer] offset where to start
    # @param [Integer] length How many bytes to read
    # 
    # @return [String] logs data
    # 
    def read_log(offset, length)
      request('readLog', offset, length)
    end
    
    ##
    # Clear the supervisor logs.
    # 
    def clear_log
      request('clearLog')
    end
    
    ##
    # Restart the supervisor process.
    # 
    def restart
      request('restart')
    end
    
    ##
    # Shutdown the supervisor process.
    #
    def shutdown
      request('shutdown')
    end
    
    ##
    # Send an event that will be received by event listener
    # subprocesses subscribing to the RemoteCommunicationEvent
    # 
    def send_remote_comm_event(type, data)
      request('sendRemoteCommEvent', type, data)
    end
    
  end
  
end
