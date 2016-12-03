require 'spec_helper'

redis_conf   = '/etc/redis/redis.conf'
service_name = 'redis'

describe 'redis::default' do
  it 'creates a redis user' do
    expect(user('redis')).to exist
  end

  it 'creates a redis group' do
    expect(group('redis')).to exist
  end

  describe file(redis_conf) do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode '644' }
  end

  describe command('/usr/local/bin/redis-server --version') do
    its(:stdout) { should match /3.2.?/ }
  end

  it 'the redis service is enabled' do
    expect(service(service_name)).to be_enabled
  end

  it 'the redis service is running' do
    expect(service(service_name)).to be_running
  end

  describe port(6379) do
    it { should be_listening.on('127.0.0.1').with('tcp') }
  end

  describe command('/usr/local/bin/redis-cli ping') do
    its(:stdout) { should match 'PONG' }
  end
end
