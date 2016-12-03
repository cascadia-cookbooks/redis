#
# Cookbook Name:: cop_redis
# Recipe:: common
# Author:: Copious Inc. <engineering@copiousinc.com>
#

user 'redis' do
    comment 'Redis Database Server'
    home    '/var/lib/redis'
    shell   '/sbin/nologin'
end

group 'redis' do
    action  :modify
    members 'redis'
    append  true
end

directories = %w(
    /var/log/redis
    /var/lib/redis
    /var/run/redis
)

directories.each do |d|
    directory d do
        user   'redis'
        group  'redis'
        mode   0755
        action :create
    end
end

directory '/etc/redis' do
    user   'root'
    group  'root'
    mode   0755
    action :create
end

template '/usr/bin/redis-shutdown' do
    cookbook 'cop_redis'
    source   'redis/shutdown.erb'
    group    'root'
    owner    'root'
    mode     0755
    backup   false
    action   :create
end
