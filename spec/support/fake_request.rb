class FakeRequest
  attr_accessor :headers, :url, :method, :body

  def initialize(params)
    @headers = params[:headers]
    @url = params[:url]
    @method = params[:method]
    @body = params[:body]
  end
end
