module RServ::IRC
  
  class Server
    attr_reader :sid, :hostname, :hops, :gecos
    
    def initialize(sid, hostname, hops, gecos)
      @sid, @hostname, @hops, @gecos = sid, hostname, hops, gecos
    end
    
  end
  
end