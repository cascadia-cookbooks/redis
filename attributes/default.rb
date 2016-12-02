default['redis'] = {
    'user'          => 'redis',
    'daemonize'     => 'yes',
    'pidfile'       => '/var/run/redis/redis.pid',
    'port'          => '6379',
    'bind'          => '127.0.0.1',
    'timeout'       => '0',
    'tcp-keepalive' => '0',
    'loglevel'      => 'notice',
    'logfile'       => '/var/log/redis/redis.log',
    'databases'     => '1',
    'maxmemory'     => '1gb',
    'sentinel'      => {
        'enabled' => false,
        'port'    => '26379',
    }
}

default['redis']['version'] = '3.2.5'

default['redis']['service_name']          = 'redis'
default['redis']['conf_file']             = '/etc/redis/redis.conf'
default['redis']['sentinel']['conf_file'] = '/etc/redis/sentinel.conf'

case node['platform_family']
when 'debian'
    default['redis']['dependencies'] = %w(autoconf binutils-doc bison build-essential flex gettext jemalloc ncurses-dev)
when 'rhel'
    default['redis']['dependencies'] = %w(autoconf bison flex gcc gcc-c++ gettext jemalloc kernel-devel make m4 ncurses-devel patch)
end
