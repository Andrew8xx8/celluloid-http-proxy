class FakeResponse
  attr_accessor :status, :body

  def initialize(params)
    @status = params[:status]
    @body = params[:body]
  end

  def self.default
    new({
      status: 200,
      body: "body"
    })
  end
end
