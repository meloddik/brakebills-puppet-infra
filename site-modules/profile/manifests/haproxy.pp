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
      'option'  => 'donlognull',
      'retries' => '3',
      'timeout' => [
        'http-request 10s',
        'queue 1m',
        'connect 10s',
        'client 1m',
        'server 1m',
        'http-keep-alive',
        'check 10s',
      ],
      'maxconn' => '3000',
    },
  }
}
