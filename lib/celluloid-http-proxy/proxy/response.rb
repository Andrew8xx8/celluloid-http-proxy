class Celluloid::Http::Proxy::Proxy::Response < Celluloid::Http::Response

  def self.build_from_response(response)
    self.new( response.status, {}, response.body)
  end

end
