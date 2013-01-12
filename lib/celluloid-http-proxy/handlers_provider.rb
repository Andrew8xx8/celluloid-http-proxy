class Celluloid::Http::Proxy::HandlersProvider
  def self.register(&block)
    new block
  end
  
  def all
    @handlers
  end

  def initialize(block)
    @handlers = []

    instance_eval &block
  end

  def handler(name, &block)
    @handlers << {
      name: name,
      block: block
    }
  end

  def get(request = nil)
    @handlers
  end
end
