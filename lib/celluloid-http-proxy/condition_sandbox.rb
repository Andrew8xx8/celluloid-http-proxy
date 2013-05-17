class Celluloid::Http::Proxy::ConditionSandbox
  def initialize(request)
    @request = request
  end

  def apply(condition, &block)
    type = condition_type! condition

    send(type, condition)
  end

  def on(condition)
    raise TransformerMissedBlockForOnCondition if condition[:block].nil?

    condition[:block].call @request
  end

  def on_param(condition)
    params = condition_params! condition


    raise MissingParamName if params[0].nil? 
    name = params[0]

    raise MissingParamValue if params[1].nil? 
    value = params[1]

    @request.query_params.has_key?(name) && @request.query_params[name] == value
  end

  private

  def condition_type!(condition)
    raise MissingTransformerCondition if condition[:condition][0].nil?
    type = condition[:condition][0]

    raise IncorrectTransformerCondition unless respond_to? type
    type
  end

  def condition_params!(condition)
    _, *params = condition[:condition]

    params
  end
end
