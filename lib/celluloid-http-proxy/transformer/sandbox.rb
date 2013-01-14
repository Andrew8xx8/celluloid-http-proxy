class Celluloid::Http::Proxy::Transformer::Sandbox

  def self.transform(object, block)
    sandbox = new object, block
    sandbox.result
  end

  def result
    @object
  end

  private

  def initialize(object, block)
    @object = object

    instance_eval &block
  end

  def transform_request(&block)
    transform &block
  end

  def transform_response(&block)
    transform &block
  end

  def transform(&block)
    block.call @object
  end
end
