class Factories
  class << self
    def request_to_localhost(query_string = "")
      Celluloid::Http::Proxy::Request.new("http://localhost:8080/" + query_string.to_s)
    end

    def localhost_handlers
      Celluloid::Http::Proxy::HandlersProvider.register do
        condition :custom_condition do |r|
          r.host == "localhost"
        end

        on :custom_condition do
          true
        end

        on :another_condition do
          true
        end
      end
    end

    def request_to_external(query_string = "")
      Celluloid::Http::Proxy::Request.new("http://external:8080/" + query_string.to_s)
    end
  end
end
