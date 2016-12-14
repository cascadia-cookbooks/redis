#
# Cookbook Name:: cop_redis
# Recipe:: install
# Author:: Copious Inc. <engineering@copiousinc.com>
#

cache   = Chef::Config[:file_cache_path]

version = node['redis']['version']
redis   = "redis-#{version}"
tarball = "#{redis}.tar.gz"

# NOTE: https not supported
download = "http://download.redis.io/releases/#{tarball}"

include_recipe 'cop_base::dependencies'

node['redis']['dependencies'].each do |p|
    package p do
        action :install
    end
end

remote_file 'download redis' do
    path   "#{cache}/#{tarball}"
    source download
    owner  'root'
    group  'root'
    mode   0644
    action :create
end

execute 'unpack redis' do
    cwd     cache
    command "gunzip #{tarball} && tar -xvf #{redis}.tar"
    not_if  "test -d #{redis}"
end

execute 'install redis' do
    cwd     "#{cache}/#{redis}"
    command 'make distclean && make && make install'
    not_if  'which redis-server'
end
