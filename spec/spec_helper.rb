require 'rubygems'
require 'bundler/setup'
require 'celluloid-http-proxy'

Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}
