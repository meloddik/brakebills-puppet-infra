class profile::unbound {
  file { '/etc/unbound/unbound.conf':
    ensure => file,
    notify => Service['unbound'],
    source => 'puppet:///modules/profile/unbound/unbound.conf',
  }
  file { '/etc/unbound/local.d/brakebills.io.conf':
    ensure => file,
    notify => Service['unbound'],
    source => 'puppet:///modules/profile/unbound/brakebills.io.conf',
  }
  file { '/etc/unbound/root.hints':
    ensure => file,
    source => 'puppet:///modules/profile/unbound/root.hints',
  }
  service { 'unbound':
    ensure   => running,
    enable   => true,
    provider => 'systemd',
  }
}
