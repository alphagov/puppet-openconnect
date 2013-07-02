# == Class: openconnect
#
# Cisco OpenConnect VPN client.
#
# === Parameters
#
# [*gateway*]
#   See openconnect::config.
#
# [*user*]
#   See openconnect::config.
#
# [*password*]
#   See openconnect::config.
#
# [*dnsupdate*]
#   See openconnect::config.
#
# [*cacerts*]
#   See openconnect::config.
#
class openconnect (
  $url = undef,
  $user = undef,
  $password = undef,
  $dnsupdate = undef,
  $cacerts = undef
) inherits openconnect::params {

  anchor { 'openconnect::begin': } ->
  class { 'openconnect::install': } ->
  class { 'openconnect::config':
    url       => $url,
    user      => $user,
    password  => $password,
    dnsupdate => $dnsupdate,
    cacerts   => $cacerts,
  }
  class { 'openconnect::service': } ->
  anchor { 'openconnect::end': }

  Anchor['openconnect::begin']  ~> Class['openconnect::service']
  Class['openconnect::install'] ~> Class['openconnect::service']
  Class['openconnect::config']  ~> Class['openconnect::service']
}
