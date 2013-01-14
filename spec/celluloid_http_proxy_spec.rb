require 'spec_helper'
require 'resolv'

describe Celluloid::Http::Proxy do
  it 'can run proxy' do
    expect(Celluloid::Http::Proxy.respond_to?(:run, true)).to be_true
  end
end
