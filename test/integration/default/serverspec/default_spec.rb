require 'spec_helper'

describe 'redis::default' do
  describe package('redis-server') do
    it { should be_installed }
  end

  describe command('redis-server --version'), :if => os[:release] == '14.04' do
    its(:stdout) { should match /2.8.4/ }
  end

  describe command('redis-server --version'), :if => os[:release] == '16.04' do
    its(:stdout) { should match /3.0.6/ }
  end

  it 'the redis service is enabled' do
    expect(service('redis-server')).to be_enabled
  end

  it 'the redis service is running' do
    expect(service('redis-server')).to be_running
  end

  describe port(6379) do
    it { should be_listening.on('127.0.0.1').with('tcp') }
  end

  it 'creates a redis user' do
    expect(user('redis')).to exist
  end

  it 'creates a redis group' do
    expect(group('redis')).to exist
  end

  describe file('/etc/redis/redis.conf') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode '644' }
  end
end
