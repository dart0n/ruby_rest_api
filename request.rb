class Request
  def self.parse(request)
    method, path = request.lines[0].split # GET /

    {
      path: path,
      method: method,
      headers: parse_headers(request),
      body: parse_body(request)
    }
  end

  def self.parse_headers(request)
    headers = {}

    request.lines[1..-1].each do |line|
      return headers if line == "\r\n"

      header, value = line.split
      header = header.gsub(':', '').downcase.to_sym
      headers[header] = value
    end
  end

  def self.parse_body(request)
    body = {}
    body = JSON.parse(request[request.index('{')..-1]).transform_keys(&:to_sym) if request.include? '{'
    body
  end
end
