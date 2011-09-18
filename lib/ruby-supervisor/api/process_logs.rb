require File.expand_path('../../proxy', __FILE__)

module RubySupervisor  
  
  module ProcessLogsAPI
    def logs
      ProcessLogsProxy.new(@xmlrpc_client, @name)
    end
  end
  
  class ProcessLogsProxy < NamedProxy
    
    ##
    # Clear the logs and reopen them,
    # both stderr and stdout logs will be cleared.
    # 
    def clear
      request('clearProcessLogs', @name)
    end
    
    ##
    # Read chunk of logs for this process.
    # 
    # @param [Integer] offset where to start from
    # @param [Integer] length How many bytes to read
    # @param [Symbol] what :stdout or :stderr
    # 
    # @return [String] Log data
    # 
    def read(offset, length, what = :stdout)
      case what
      when :stdout  then  call = 'readProcessStdoutLog'
      when :stderr  then  call = 'readProcessStderrLog'
      else
        raise "invalid value for what parameter: #{what}"
      end
      
      request(call, @name, offset, length)
    end
    
    ##
    # Tail chunk of logs for this process.
    # 
    # What is the real difference between read and tail ?
    # I have currently no idea ! documentation is rather...
    # vague.
    # 
    # @param [Integer] offset where to start from
    # @param [Integer] length How many bytes to read
    # @param [Symbol] what :stdout or :stderr
    # 
    # @return [Array] [bytes read, offset, overflow]
    #
    def tail(offset, length, what = :stdout)
      case what
      when :stdout  then  call = 'tailProcessStdoutLog'
      when :stderr  then  call = 'tailProcessStderrLog'
      else
        raise "invalid value for what parameter: #{what}"
      end
      
      request(call, @name, offset, length)
    end
    
  end
  
end
