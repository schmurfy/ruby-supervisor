require File.expand_path('../../proxy', __FILE__)
require File.expand_path('../process_logs', __FILE__)

module RubySupervisor  
  
  module ProcessAPI
    def process(name)
      ProcessProxy.new(self, name)
    end
  end
  
  ##
  # Process Proxy.
  # 
  # Note: you can address programs in a group via this name:
  # <group>:<process>
  # 
  class ProcessProxy < NamedProxy
    
    include ProcessLogsAPI
        
    STATE_TO_STR = {
           0 => :stopped,
          10 => :starting,
          20 => :running,
          30 => :backoff,
          40 => :stopping,
         100 => :exited,
         200 => :fatal,
        1000 => :unknown
      }.freeze
    
    STR_TO_STATE = STATE_TO_STR.invert.freeze
    
    ##
    # Return process state as symbol.
    # 
    # @return [Symbol] The process state
    # 
    def state
      state = infos['state']
      STATE_TO_STR[ state ]
    end
    
    ##
    # Return informations about process.
    # 
    # @return [Hash] Informations about the process
    # 
    def infos
      request('getProcessInfo', @name)
    end
    
    ##
    # Start the process.
    # 
    # @param [Boolean] wait if true the call will
    #   block until the process is started.
    # 
    def start(wait = true)
      request('startProcess', @name, wait)
    end
    
    ##
    # Stop the process.
    # 
    # @param [Boolean] wait if true the call will
    #   block until the process is stopped.
    #
    def stop(wait = true)
      request('stopProcess', @name, wait)
    end
    
    ##
    # Restart the process.
    # If you pass a block to this method it will get called
    # after the actual restart.
    # Be aware that wehn using a block with wait = false your block
    # will be scheduled in a separate thread !
    # 
    # @param [Boolean] wait if true the call will
    #   block until the process is restarted.
    #
    def restart(wait = true, &block)
      if wait
        begin
          stop(true)
        ensure
          start(true)
        end
        
        block.call if block
      else
        Thread.new do
          stop(true)
          start(true)
          block.call if block
        end
      end
    end
    
    ##
    # Write data to the process standard input.
    # 
    # @param [String] data data to send to the
    #   process.
    # 
    def send_stdin(data)
      request('sendProcessStdin', @name, data)
    end
    
  end
  
end
