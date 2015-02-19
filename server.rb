require 'em-websocket'

@clients = []

EM.run {
  EM::WebSocket.run(:host => "0.0.0.0", :port => 8080) do |ws|
    ws.onopen { |handshake|
      @clients << ws
      puts "WebSocket connection open"

      # Access properties on the EM::WebSocket::Handshake object, e.g.
      # path, query_string, origin, headers

      # Publish message to the client
      ws.send "Hello Client, you connected to simchat!"
    }

    ws.onclose do
      ws.send "Closed."
      @clients.delete ws
    end

    ws.onmessage do |msg|
      puts "Recieved message: #{msg}"
      @clients.each do |socket|
        socket.send msg
      end
    end
  end
}







