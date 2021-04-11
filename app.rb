require 'socket'
require './request'
require './response'
require './database'

server = TCPServer.new 5000
Database.connect

loop do
  client = server.accept
  request = client.readpartial(2048)

  request = Request.new.parse(request)
  response = ResponseBuilder.new.prepare(request)

  puts "#{request.fetch(:method)} #{request.fetch(:path)} #{response.code}"

  response.send(client)
  client.close
end
