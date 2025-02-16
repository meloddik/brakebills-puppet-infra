class profile::keepalived_master {
  file { '/etc/keepalived/keepalived.conf':
    ensure => file,
    notify => Service['keepalived'],
    source => 'puppet:///modules/profile/keepalived_master/keepalived.conf',
  }
  service { 'keepalived':
    ensure   => running,
    enable   => true,
    provider => 'systemd',
  }
}
