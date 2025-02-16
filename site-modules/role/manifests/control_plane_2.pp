class role::control_plane_2 {
  include profile::haproxy
  include profile::keepalived_backup
}
