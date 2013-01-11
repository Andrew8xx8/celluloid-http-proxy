require 'spec_helper'
require 'resolv'

describe Celluloid::Http::Proxy do
  it 'can register handler' do
    expect(Celluloid::Http::Proxy.respond_to?(:register_handler, true)).to be_true
  end
end
