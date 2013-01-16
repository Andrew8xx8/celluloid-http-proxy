require "celluloid-http-proxy/version"
require 'simple_pid'
require 'reel'
require 'uri'
require 'virtus'
require 'multi_json'
require 'active_support'
require 'active_support/core_ext/object/to_query'
require 'simple_router'
require 'celluloid-http'

module Celluloid
  module Http
    module Proxy
      autoload :Connection, 'celluloid-http-proxy/connection'
      autoload :Runner,     'celluloid-http-proxy/runner'
      autoload :TransformersProvider, 'celluloid-http-proxy/transformers_provider'
      autoload :Transformer, 'celluloid-http-proxy/transformer'

      autoload :Request, 'celluloid-http-proxy/request'
      autoload :Response, 'celluloid-http-proxy/response'

      autoload :ConditionSandbox, 'celluloid-http-proxy/condition_sandbox'
      class NotFound < Exception; end

      def self.register(&block)
        @transformers_provider = Celluloid::Http::Proxy::TransformersProvider.register &block
      end

      def self.run(argv)
        Runner.run(argv, @transformers_provider)
      end
    end
  end
end
