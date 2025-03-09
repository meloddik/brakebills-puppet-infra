class profile::resolved {
  service { 'systemd-resolved':
    ensure => running,
    enable => true,
  }

  file { '/etc/systemd/resolved.conf':
    ensure => 'file',
    source => 'puppet:///modules/profile/resolved/resolved.conf',
    notify => Service['systemd-resolved'],
  }
}
