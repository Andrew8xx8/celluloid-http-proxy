class Celluloid::Http::Proxy::Request < Celluloid::Http::Request

  def self.build_from_request(request)

    self.new("http://#{request.headers["Host"]}#{request.path}", {
      method: request.method,
      raw_body: request.body
    })
  end

  def remove_param(name)
    params = query_params
    param = params.delete name
    self.query = params
    param
  end
end
