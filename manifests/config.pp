# == Class openconnect::config
#
# This class is called from openconnect
#
class openconnect::config {
  $url       = $::openconnect::url
  $user      = $::openconnect::user
  $pass      = $::openconnect::pass
  $dnsupdate = $::openconnect::dnsupdate
  $cacerts   = $::openconnect::cacerts

  validate_string($url, $user, $pass, $cacerts)
  validate_bool($dnsupdate)

  file { '/etc/openconnect':
    ensure => directory,
    mode   => '0700',
  }

  file { '/etc/openconnect/network.passwd':
    ensure  => present,
    mode    => '0600',
    content => $pass,
  }

  $cacerts_ensure = $cacerts ? {
    ''      => absent,
    default => present,
  }
  file { '/etc/openconnect/network.cacerts':
    ensure  => $cacerts_ensure,
    content => $cacerts,
  }

  file { '/etc/init/openconnect.conf':
    ensure  => present,
    mode    => '0600',
    content => template('openconnect/etc/init/openconnect.conf.erb'),
  }
}
