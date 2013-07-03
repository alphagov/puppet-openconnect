# == Class: openconnect
#
# Cisco OpenConnect VPN client.
#
# === Parameters
#
# [*url*]
#   URL for your VPN endpoint, including any profile name.
#
# [*user*]
#   Xauth username.
#
# [*password*]
#   Xauth password.
#
# [*dnsupdate*]
#   Boolean, whether to accept nameservers from the VPN endpoint.
#   Default: false
#
# [*cacerts*]
#   PEM string of CAs to trust.
#   Default: ''
#
class openconnect(
  $url,
  $user,
  $password,
  $dnsupdate = false,
  $cacerts = ''
) inherits openconnect::params {

  anchor { 'openconnect::begin': } ->
  class { 'openconnect::install': } ->
  class { 'openconnect::config': }
  class { 'openconnect::service': } ->
  anchor { 'openconnect::end': }

  Anchor['openconnect::begin']  ~> Class['openconnect::service']
  Class['openconnect::install'] ~> Class['openconnect::service']
  Class['openconnect::config']  ~> Class['openconnect::service']
}
