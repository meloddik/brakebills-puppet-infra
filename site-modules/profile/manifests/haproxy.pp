class profile::haproxy {
  class { 'haproxy':
    merge_options    => true,
    global_options   => {
      'log'     => '127.0.0.1 local2',
      'pidfile' => '/var/run/haproxy.pid',
      'maxconn' => '4000',
      'daemon'  => '',
    },
    defaults_options => {
      'mode'    => 'http',
      'log'     => 'global',
      'option'  => [
        'dontlognull',
        'http-server-close',
        'redispatch',
      ],
      'retries' => '3',
      'timeout' => [
        'http-request 10s',
        'queue 1m',
        'connect 10s',
        'client 1m',
        'server 1m',
        'http-keep-alive 10s',
        'check 10s',
      ],
      'maxconn' => '3000',
    },
  }
  haproxy::listen { 'api-server-6443':
    ipaddress => '*',
    ports     => [6443],
    mode      => 'tcp',
    options   => {
      'option'  => [
        'httpchk GET /readyz HTTP/1.0',
        'log-health-checks',
      ],
      'balance' => 'roundrobin',
    },
  }
}
