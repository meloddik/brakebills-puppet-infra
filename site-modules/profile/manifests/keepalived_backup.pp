class profile::keepalived_backup {
  file { '/etc/keepalived/keepalived.conf':
    ensure => file,
    notify => Service['keepalived'],
    source => 'puppet:///modules/profile/keepalived_backup/keepalived.conf',
  }
  service { 'keepalived':
    ensure   => running,
    enable   => true,
    provider => 'systemd',
  }
}
