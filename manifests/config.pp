# == Class openconnect::config
#
# This class is called from openconnect
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
class openconnect::config(
  $url,
  $user,
  $password,
  $dnsupdate = false,
  $cacerts = ''
) {
  validate_string($url, $user, $password, $cacerts)
  validate_bool($dnsupdate)

  file { '/etc/openconnect':
    ensure => directory,
    mode   => '0700',
  }

  file { '/etc/openconnect/network.passwd':
    ensure  => present,
    mode    => '0600',
    content => $password,
  }

  $cacerts_ensure = $cacerts ? {
    ''      => absent,
    default => present,
  }
  file { '/etc/openconnect/network.cacerts':
    ensure  => $cacerts_ensure,
    content => $cacerts,
  }

  $dnsupdate_real = $dnsupdate ? {
    true    => 'yes',
    default => 'no',
  }
  file { '/etc/init/openconnect.conf':
    ensure  => present,
    mode    => '0600',
    content => template('openconnect/etc/init/openconnect.conf.erb'),
  }
}
