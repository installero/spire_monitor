require 'soap/rpc/driver'

URL = 'http://localhost:8080/'
NAMESPACE = 'spire:monitor'

begin

   driver = SOAP::RPC::Driver.new(URL, NAMESPACE)

   driver.add_method('get_xml', 'date')

   puts driver.get_xml('17.07.2011')
   puts driver.get_xml('16.07.2011')
   puts driver.get_xml('test')

rescue => err

   puts err.message

end

