#
# Cookbook Name:: cop_redis
# Recipe:: redis
# Author:: Copious Inc. <engineering@copiousinc.com>
#

# NOTE: systemd
template '/usr/lib/systemd/system/redis.service' do
    cookbook 'cop_redis'
    source   'systemd/redis.service.erb'
    group    'root'
    owner    'root'
    mode     0644
    backup   false
    action   :create
    only_if  'ps -p 1 -o comm= | grep systemd'
end

# NOTE: initd
template '/etc/init.d/redis' do
    cookbook 'cop_redis'
    source   'initd/redis.init.erb'
    group    'root'
    owner    'root'
    mode     0755
    backup   false
    action   :create
    not_if   'ps -p 1 -o comm= | grep systemd'
end

template 'installing redis config' do
    cookbook 'cop_redis'
    path     node['redis']['conf_file']
    source   'redis/redis.conf.erb'
    group    'root'
    owner    'root'
    mode     0644
    backup   false
    action   :create
    notifies :restart, 'service[redis]', :delayed
end

service 'redis' do
    action [:enable, :start]
end
