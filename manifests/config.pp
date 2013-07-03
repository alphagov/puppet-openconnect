# == Class openconnect::config
#
# This class is called from openconnect
#
class openconnect::config {
  $url       = $::openconnect::url
  $user      = $::openconnect::user
  $password  = $::openconnect::password
  $dnsupdate = $::openconnect::dnsupdate
  $cacerts   = $::openconnect::cacerts

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
