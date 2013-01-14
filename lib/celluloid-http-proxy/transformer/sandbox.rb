class Celluloid::Http::Proxy::Transformer::Sandbox

  def self.transform_response(object, block)
    sandbox = new object, block, :response
    sandbox.result
  end

  def self.transform_request(object, block)
    sandbox = new object, block, :request
    sandbox.result
  end

  def result
    @object
  end

  private

  def initialize(object, block, type)
    @object = object
    @type = type

    instance_eval &block
  end

  def transform_request(&block)
    return @object if @type == :response

    transform &block
  end

  def transform_response(&block)
    return @object if @type == :request

    transform &block
  end

  def transform(&block)
    block.call @object
  end
end
