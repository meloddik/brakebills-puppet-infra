class role::control_plane_1 {
  include profile::haproxy
  include profile::keepalived_master
}
