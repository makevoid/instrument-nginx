require_relative 'env'

event_main = -> (ws) {
  event_onmessage = -> (msg, type) {
    puts "Received message: #{msg}"
    ws.send "-> #{msg.upcase}", type: type
  }
  event_onmessage
}

event_conn_open = -> (_) {
  puts "Client connected"
}

event_conn_close = -> (_, _) {
  puts "Client disconnected"
}

events = -> (ws) {
   ws.onopen    &event_conn_open
   ws.onmessage &event_main.(ws)
   ws.onclose   &event_conn_close
}

event_loop = -> {
  WebSocket::EventMachine::Server.start host: "0.0.0.0", port: 3001, &events
}

EM.run &event_loop
