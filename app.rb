require 'socket'
require 'json'
require './response'
require './database'

class RequestParser
  def parse(request)
    method, path = request.lines[0].split # GET /

    {
      path: path,
      method: method,
      headers: parse_headers(request),
      body: parse_body(request)
    }
  end

  def parse_headers(request)
    headers = {}

    request.lines[1..-1].each do |line|
      return headers if line == "\r\n"

      header, value = line.split
      header = header.gsub(':', '').downcase.to_sym
      headers[header] = value
    end
  end

  def parse_body(request)
    body = {}
    body = JSON.parse(request[request.index('{')..-1]).transform_keys(&:to_sym) if request.include? '{'
    body
  end
end

server = TCPServer.new 5000
Database.connect

loop do
  client = server.accept
  request = client.readpartial(2048)

  request = RequestParser.new.parse(request)
  response = ResponseBuilder.new.prepare(request)

  puts "#{request.fetch(:method)} #{request.fetch(:path)} #{response.code}"

  response.send(client)
  client.close
end
