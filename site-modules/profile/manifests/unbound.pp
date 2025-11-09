class profile::unbound {
  service { 'systemd-resolved':
    ensure   => running,
    enable   => true,
    provider => 'systemd',
  }
  file { '/etc/systemd/resolved.conf':
    ensure => 'file',
    notify => Service['systemd-resolved'],
    source => 'puppet:///modules/profile/unbound/resolved.conf',
  }
  file { '/etc/default/unbound':
    ensure => 'file',
    source => 'puppet:///modules/profile/unbound/default',
    notify => Service['systemd-resolved'],
  }
  package { 'unbound':
    ensure => 'present',
  }
  exec { 'setup-unbound-certs':
    command => '/usr/sbin/unbound-control-setup',
    unless  => '/usr/bin/test -f /etc/unbound/unbound_server.pem',
  }
  file { '/etc/unbound/local.d':
    ensure => 'directory',
  }
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
