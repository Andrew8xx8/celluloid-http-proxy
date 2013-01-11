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
      autoload :Transformer, 'celluloid-http-proxy/transformer'
      autoload :Runner, 'celluloid-http-proxy/runner'

      class NotFound < Exception; end

      def self.register(&block)
      end

      def self.run(argv)
        Runner.run(argv)
      end
    end
  end
end
