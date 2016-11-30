require 'spec_helper'

case os[:family]
when 'ubuntu', 'debian'
    package_name = 'redis-server'
    service_name = 'redis-server'
    redis_conf = '/etc/redis/redis.conf'
when 'redhat'
    package_name = 'redis'
    service_name = 'redis'
    redis_conf = '/etc/redis.conf'
end

describe 'redis::default' do
  describe package(package_name) do
    it { should be_installed }
  end

  describe command("#{package_name} --version"), :if => os[:release] == '14.04' do
    its(:stdout) { should match /2.8.4/ }
  end

  describe command("#{package_name} --version"), :if => os[:release] == '16.04' do
    its(:stdout) { should match /3.0.6/ }
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
end
