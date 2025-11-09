class profile::netplan {
  service { 'systemd-networkd':
    ensure   => running,
    enable   => true,
    provider => 'systemd',
  }
  exec { 'apply-netplan':
    command     => '/usr/sbin/netplan apply',
    refreshonly => true,
  }
  file { '/etc/netplan/01-brakebills-seam.yaml':
    ensure  => file,
    content => epp('profile/seam.epp'),
    mode    => '0600',
    notify  => Exec['apply-netplan'],
  }
}
