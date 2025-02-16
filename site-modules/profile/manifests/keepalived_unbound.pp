class profile::keepalived_unbound {
  file { '/etc/keepalived/keepalived.conf':
    ensure => file,
    notify => Service['keepalived'],
    source => 'puppet:///modules/profile/keepalived_unbound/keepalived.conf',
  }
  service { 'keepalived':
    ensure   => running,
    enable   => true,
    provider => 'systemd',
  }
}
