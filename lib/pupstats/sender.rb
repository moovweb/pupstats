module Pupstats
  class Sender
    require 'socket'

    def send_data(data_array)
      begin
	sock = TCPSocket.open(@@CARBON_SERVER, @@CARBON_PORT)
	sock.puts(data_array.join("\n"))
	sock.close
      rescue Exception => e
	puts "Send_data_error: #{e.message}"
      end
    end

  end
end
