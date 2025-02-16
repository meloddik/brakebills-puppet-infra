class role::dns_server {
  include profile::haproxy
  include profile::keepalived_unbound
}
