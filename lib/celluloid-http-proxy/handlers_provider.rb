class Celluloid::Http::Proxy::HandlersProvider
  def self.register(&block)
    new block
  end

  def all
    @handlers
  end

  def initialize(block)
    @handlers = []
    @conditions = {}

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

  def condition(name, &block)
    @conditions[name] = block
  end

  def apply_condition(name, request)
    raise CustomConditionNotFound unless @conditions.has_key? name

    @conditions[name].call request
  end
end
