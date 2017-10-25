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
# [*pass*]
#   Xauth password.
#
# [*dnsupdate*]
#   Boolean, whether to accept nameservers from the VPN endpoint.
#   Default: true
#
# [*cacerts*]
#   PEM string of CAs to trust.
#   Default: ''
#
# [*servercert*]
#   SHA1 fingerprint of trusted server's SSL certificate.
#   Default: ''
#
# [*proxy*]
#   The proxy to use to connect to the VPN
#   Default: ''
#
# [*version*]
#   Package version
#   Default: 'present'
#
class openconnect(
  $url,
  $user,
  $pass,
  $dnsupdate = true,
  $cacerts = '',
  $servercert = '',
  $authgroup = undef,
  $proxy = '',
  $version = 'present',
  $ensure = 'present',
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
