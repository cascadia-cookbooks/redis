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

# latest stable package release
case node['platform_version']
when '14.04'
    default['redis']['version'] = '2.8.4'
when '16.04'
    default['redis']['version'] = '3.0.6'
end
