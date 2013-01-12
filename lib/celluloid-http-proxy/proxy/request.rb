class Celluloid::Http::Proxy::Proxy::Request < Celluloid::Http::Request

  def self.build_from_request(request)
    self.new("http://#{request.headers["Host"]}#{request.url}", {
      method: request.method,
      body: request.body
    })
  end

  def remove_param(name)
    params = query_params
    param = params.delete name
    self.query = params
    param
  end

  def to_env
    Rack::MockRequest.env_for(@uri, method: method, input: body)
  end

end
