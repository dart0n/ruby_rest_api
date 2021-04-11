class Response
  attr_reader :code

  def initialize(code:, data: '')
    @response =
      "HTTP/1.1 #{code}\r\n" \
      "Content-Length: #{data.size}\r\n" \
      "\r\n" \
      "#{data}\r\n"

    @code = code
  end

  def send(client)
    client.write(@response)
  end
end

class ResponseBuilder
  SERVER_ROOT = File.join(File.dirname(__FILE__), '/')
  USERS_API = '/api/v1/users'

  def prepare(request)
    path        = request.fetch(:path)
    method      = request.fetch(:method)
    body        = request.fetch(:body)
    id          = %r{([^/]+$)}.match(path) && %r{([^/]+$)}.match(path)[0]
    sort_option = /sort_by=(.*)/.match(path) && /sort_by=(.*)/.match(path)[1]
    sort_path   = "#{USERS_API}?sort_by=#{sort_option}"

    case [path, method]
    when ['/', 'GET']                     then respond_with("#{SERVER_ROOT}index.html")
    when [USERS_API, 'GET']               then send_response(**UsersController.index)
    when [USERS_API, 'POST']              then send_response(**UsersController.create(body))
    when ["#{USERS_API}/#{id}", 'PUT']    then send_response(**UsersController.update(id, body))
    when ["#{USERS_API}/#{id}", 'DELETE'] then send_response(**UsersController.destroy(id))
    when [sort_path, 'GET']               then send_response(**UsersController.sort(sort_option))
    else
      send_not_found
    end
  end

  def respond_with(path)
    if File.exist?(path)
      Response.new code: 200, data: File.binread(path)
    else
      send_not_found
    end
  end

  def send_response(code: 200, data: '')
    Response.new code: code, data: data.to_json
  end

  def send_not_found
    Response.new code: 404, data: ''
  end
end
