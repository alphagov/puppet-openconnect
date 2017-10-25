# == Class openconnect::config
#
# This class is called from openconnect
#
class openconnect::config {
  $url        = $::openconnect::url
  $user       = $::openconnect::user
  $pass       = $::openconnect::pass
  $dnsupdate  = $::openconnect::dnsupdate
  $cacerts    = $::openconnect::cacerts
  $servercert = $::openconnect::servercert
  $upstart    = $::openconnect::upstart
  $proxy      = $::openconnect::proxy
  $ensure     = $::openconnect::ensure

  validate_string($url, $user, $pass, $cacerts, $servercert)
  validate_bool($dnsupdate)

  if $ensure == 'present' {
    $ensure_dir = 'directory'
  } else {
    $ensure_dir = $ensure
  }

  file { '/etc/openconnect':
    ensure => $ensure_dir,
    mode   => '0700',
  }

  file { '/etc/openconnect/network.passwd':
    ensure  => $ensure,
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
  if $upstart {
    file { '/etc/init/openconnect.conf':
      ensure  => $ensure,
      mode    => '0600',
      content => template('openconnect/etc/init/openconnect.conf.erb'),
    }
  } else {
    file { '/etc/init.d/openconnect':
      ensure  => $ensure,
      mode    => '0700',
      content => template('openconnect/etc/init.d/openconnect.erb'),
    }
  }
}
