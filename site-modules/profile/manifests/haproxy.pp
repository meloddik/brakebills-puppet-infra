class profile::haproxy {
  file { '/etc/haproxy/haproxy.cfg':
    ensure => file,
    notify => Service['haproxy'],
    source => 'puppet:///modules/profile/haproxy/haproxy.cfg',
  }
  service { 'haproxy':
    ensure   => running,
    enable   => true,
    provider => 'systemd',
  }
}
