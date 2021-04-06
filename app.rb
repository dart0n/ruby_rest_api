require "socket"
require "json"
require "./users_controller.rb"

class RequestParser
  def parse(request)
    method, path = request.lines[0].split # GET /

    {
      path: path,
      method: method,
      headers: parse_headers(request)
    }
  end

  def parse_headers(request)
    headers = {}

    request.lines[1..-1].each do |line|
      return headers if line == "\r\n"

      header, value = line.split
      header = header.gsub(":", "").downcase.to_sym
      headers[header] = value
    end
  end

  def parse_body(request)
    body = {}

    if request.include? "{"
      body = JSON.parse(request[request.index("{")..-1]).transform_keys(&:to_sym)
    end

    body
  end
end

class Response
  attr_reader :code

  def initialize(code:, data: "")
    @response =
      "HTTP/1.1 #{code}\r\n" +
      "Content-Length: #{data.size}\r\n" +
      "\r\n" +
      "#{data}\r\n"

    @code = code
  end

  def send(client)
    client.write(@response)
  end
end

class ResponseBuilder
  SERVER_ROOT = File.join(File.dirname(__FILE__), "/")
  USERS_API = "/api/v1/users"

  def prepare(request)
    if request.fetch(:path) == "/"
      respond_with(SERVER_ROOT + "index.html")
    elsif request.fetch(:path) == USERS_API and request.fetch(:method) == "POST"
      send_ok_response("User created")
    elsif request.fetch(:path) == USERS_API
      users = UsersController.index.to_json
      send_ok_response(users)
    else
      respond_with(SERVER_ROOT + request.fetch(:path))
    end
  end

  def respond_with(path)
    if File.exists?(path)
      send_ok_response(File.binread(path))
    else
      send_file_not_found
    end
  end

  def send_ok_response(data)
    Response.new(code: 200, data: data)
  end

  def send_file_not_found
    Response.new(code: 404)
  end
end

server = TCPServer.new 5000

loop do
  client = server.accept
  request = client.readpartial(2048)

  request = RequestParser.new.parse(request)
  response = ResponseBuilder.new.prepare(request)

  puts "#{request.fetch(:method)} #{request.fetch(:path)} #{response.code}"

  response.send(client)
  client.close
end
