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

  def condition(name, &block)
    @conditions[name] = block
  end

  def on(condition, &block)
    @handlers << {
      condition: condition,
      block: block
    }
  end

  def get_condition(name)
    raise CustomConditionNotFound unless condition_exists? name

    @conditions[name]
  end

  def get_handlers(condition, request)
    return search_handlers(condition) if apply_condition(condition, request)
  end

private
  def search_handlers(condition)
    @handlers.select {|s| s[:condition] == condition }
  end

  def apply_condition(name, request)
    get_condition(name).call request
  end

  def condition_exists?(name)
    @conditions.has_key? name
  end
end
