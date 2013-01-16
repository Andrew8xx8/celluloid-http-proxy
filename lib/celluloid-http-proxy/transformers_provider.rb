class Celluloid::Http::Proxy::TransformersProvider

  def self.register(&block)
    new block
  end

  def initialize(block)
    @handlers = []
    @conditions = {}

    instance_eval &block
  end

  def transform_by(transformer, *condition, &block)
    @handlers << {
      condition: condition,
      transformer: transformer,
      block: block
    }
  end

  def get_handlers(condition, request)
    return [] unless apply_condition(condition, request)
    search_handlers(condition)
  end

  def for_request(request)
    sandbox = Celluloid::Http::Proxy::ConditionSandbox.new request

    handlers = []
    @handlers.each do |handler|
      if sandbox.apply(handler)
        handlers << handler[:transformer].new(request)
      end
    end

    handlers
  end

private
  def search_handlers(condition)
    @handlers.select {|s| s[:condition] == condition }
  end

  def apply_condition(handler, request)

  end

  def condition_exists?(name)
    @conditions.has_key? name
  end
end
