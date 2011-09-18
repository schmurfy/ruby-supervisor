module RubySupervisor
  
  class Proxy
    def initialize(xmlrpc_client)
      @xmlrpc_client = xmlrpc_client
    end
    
  private
    def request(cmd, *args)
      @xmlrpc_client.send(:request, cmd, *args)
    end
  end
  
  class NamedProxy < Proxy
    attr_reader :name
    
    def initialize(xmlrpc_client, name)
      super(xmlrpc_client)
      @name = name
    end
  end
  
end
