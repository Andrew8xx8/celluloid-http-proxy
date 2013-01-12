class FakeResponse
  attr_accessor :status, :body

  def initialize(params)
    @status = params[:status]
    @body = params[:body]
  end
end
