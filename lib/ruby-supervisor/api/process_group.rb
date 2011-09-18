require File.expand_path('../../proxy', __FILE__)

# TODO: find what the hell this call is supposed to do:
# addProcessGroup
# 

module RubySupervisor  
  
  module ProcessGroupAPI
    def group(name)
      ProcessGroupProxy.new(self, name)
    end
  end
  
  ##
  # Process Group Proxy.
  # 
  class ProcessGroupProxy < NamedProxy
    
    ##
    # Start the process group.
    # 
    # @param [Boolean] wait if true the call will
    #   block until the process group is started.
    #
    def start(wait = true)
      request('startProcessGroup', @name, wait)
    end
    
    ##
    # Stop the process group.
    # 
    # @param [Boolean] wait if true the call will
    #   block until the process group is stopped.
    #
    def stop(wait = true)
      request('stopProcessGroup', @name, wait)
    end
    
    ##
    # Restart the process group.
    # 
    # @param [Boolean] wait if true the call will
    #   block until the process group is restarted.
    #
    def restart(wait = true)
      stop(wait)
      start(wait)
    end
    
  end
  
end
