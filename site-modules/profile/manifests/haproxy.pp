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
  @@haproxy::balancemember { 'api_server':
    listening_service => 'api-server-6443',
    ports             => 6443,
    server_names      => $facts['networking']['hostname'],
    ipaddress         => $facts['networking']['ip'],
    options           => [
      'check',
      'check-ssl',
    ],
  }
  Haproxy::Balancemember <<| listening_service == 'api-server-6443' |>>
  haproxy::balancermember { 'api_server':
    listening_service => 'api-server-6443',
    ports             => 6443,
    server_names      => [
      'master0',
      'master1',
      'master2',
    ],
    ipaddresses       => [
      '10.1.30.2',
      '10.1.30.5',
      '10.1.30.7',
    ],
    options           => [
      'check',
      'check-ssl',
    ],
  }
  haproxy::listen { 'machine-config-server-22623':
    ipaddress => '*',
    ports     => [22623],
    mode      => 'tcp',
  }
  @@haproxy::balancemember { 'machine_config_server':
    listening_service => 'machine-config-server-22623',
    ports             => 22623,
    server_names      => $facts['networking']['hostname'],
    ipaddress         => $facts['networking']['ip'],
    options           => [
      'check',
    ],
  }
  Haproxy::Balancemember <<| listening_service == 'machine-config-server-22623' |>>
  haproxy::balancermember { 'machine_config_server':
    listening_service => 'machine-config-server-22623',
    ports             => 22623,
    server_names      => [
      'master0',
      'master1',
      'master2',
    ],
    ipaddresses       => [
      '10.1.30.2',
      '10.1.30.5',
      '10.1.30.7',
    ],
    options           => [
      'check',
    ],
  }
  haproxy::listen { 'ingress-router-443':
    ipaddress => '*',
    ports     => [443],
    mode      => 'tcp',
    options   => {
      balance => 'source',
    },
  }
  @@haproxy::balancemember { 'ingress_router_secure':
    listening_service => 'ingress-router-443',
    ports             => 443,
    server_names      => $facts['networking']['hostname'],
    ipaddress         => $facts['networking']['ip'],
    options           => [
      'check',
    ],
  }
  Haproxy::Balancemember <<| listening_service == 'ingress-router-443' |>>
  haproxy::balancermember { 'ingress_router_secure':
    listening_service => 'ingress-router-443',
    ports             => 443,
    server_names      => [
      'compute0',
      'compute1',
    ],
    ipaddresses       => [
      '10.1.10.254',
      '10.1.10.253',
    ],
    options           => [
      'check',
    ],
  }
  haproxy::listen { 'ingress-router-80':
    ipaddress => '*',
    ports     => [80],
    mode      => 'tcp',
    options   => {
      balance => 'source',
    },
  }
  @@haproxy::balancemember { 'ingress_router':
    listening_service => 'ingress-router-80',
    ports             => 80,
    server_names      => $facts['networking']['hostname'],
    ipaddress         => $facts['networking']['ip'],
    options           => [
      'check',
    ],
  }
  Haproxy::Balancemember <<| listening_service == 'ingress-router-80' |>>
  haproxy::balancermember { 'ingress_router':
    listening_service => 'ingress-router-80',
    ports             => 80,
    server_names      => [
      'compute0',
      'compute1',
    ],
    ipaddresses       => [
      '10.1.10.254',
      '10.1.10.253',
    ],
    options           => [
      'check',
    ],
  }
}
