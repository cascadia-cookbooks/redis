default['redis'] = {
    'user'          => 'redis',
    'daemonize'     => 'yes',
    'pidfile'       => '/var/run/redis/redis-server.pid',
    'port'          => '6379',
    'bind'          => '127.0.0.1',
    'timeout'       => '0',
    'tcp-keepalive' => '0',
    'loglevel'      => 'notice',
    'logfile'       => '/var/log/redis/redis-server.log',
    'databases'     => '1',
    'maxmemory'     => '1gb',
    'sentinel'      => {
        'enabled' => false,
        'port'    => '26379',
    }
}

case node['platform_family']
when 'debian'
    default['redis']['package_name'] = 'redis-server'
    default['redis']['service_name'] = 'redis-server'
    default['redis']['conf_file'] = '/etc/redis/redis.conf'
    default['redis']['sentinel']['conf_file'] = '/etc/redis/sentinel.conf'
when 'rhel', 'fedora'
    default['redis']['package_name'] = 'redis'
    default['redis']['service_name'] = 'redis'
    default['redis']['conf_file'] = '/etc/redis.conf'
    default['redis']['sentinel']['conf_file'] = '/etc/sentinel.conf'
end

# latest stable package release
version  = node['platform_version'].to_i
case version
when '14', '6'
    default['redis']['version'] = '2:2.8.4-*'
when '16', '7'
    default['redis']['version'] = '2:3.0.6-*'
end
