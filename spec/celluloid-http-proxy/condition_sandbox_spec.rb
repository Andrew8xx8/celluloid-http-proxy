require 'spec_helper'
require 'resolv'

describe Celluloid::Http::Proxy::ConditionSandbox do
  it 'can apply :on_param conditions to request' do
    request = Factories.request_to_localhost("movies.json?movie_source_id=1")

    sandbox = Celluloid::Http::Proxy::ConditionSandbox.new request
    sandbox.apply({
      condition: [:on_param, 'movie_source_id', '1']
    }).should eq true
  end

  it 'can apply :on conditions to request' do
    request = Factories.request_to_localhost("movies.json?movie_source_id=1")

    sandbox = Celluloid::Http::Proxy::ConditionSandbox.new request
    sandbox.apply({
      condition: [:on],
      block: Proc.new do |r|
        r.host == "localhost"
      end
    }).should eq true

    sandbox.apply({
      condition: [:on],
      block: Proc.new do |r|
        r.host == "external-host"
      end
    }).should eq false
  end

  it 'must raise exception if Proc missed for :on conditions' do
    request = Factories.request_to_localhost("movies.json?movie_source_id=1")

    sandbox = Celluloid::Http::Proxy::ConditionSandbox.new request
    condition = {
      condition: [:on],
      block: nil
    }

    expect { sandbox.apply condition }.to raise_error
  end

  it 'must raise exception if condition type missed' do
    request = Factories.request_to_localhost("movies.json?movie_source_id=1")

    sandbox = Celluloid::Http::Proxy::ConditionSandbox.new request
    condition = {
      condition: [:on_missed_codition_type],
      block: nil
    }

    expect { sandbox.apply condition }.to raise_error
  end

end
