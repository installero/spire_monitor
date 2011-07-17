require 'rubygems'
require 'mongrel-soap/rpc/standaloneServer'

HOST = 'localhost'
PORT = '8080'
SERVER_NAME = 'Spire Monitor'
NAMESPACE = 'spire:monitor'

begin
  class SpireMonitorServer < MongrelSOAP::RPC::StandaloneServer

    def initialize(*args)
      super(*args)
      add_method(self, 'get_xml')
    end

    def get_xml(date = Time.now.strftime('%d.%m.%Y'))
      date = Date.parse(date).strftime("%d.%m.%Y")
      filename = File.dirname(__FILE__) + "/xml/#{date}.xml"
      if File.exists?(filename)
        return File.read(filename)
      else
        return 'Spire Monitor has no data for this date. Sorry.'
      end
    end
  end

  server = SpireMonitorServer.new(SERVER_NAME, NAMESPACE, HOST, PORT)

  trap('INT'){server.shutdown}

  server.start

rescue => err

  puts err.message
  
end
