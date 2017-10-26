# == Class openconnect::install
#
# Install OpenConnect and vpnc (required for vpnc-script).
#
class openconnect::install {
  include openconnect::params

  $ensure = $openconnect::ensure

  if $ensure == 'present' {
    package { $openconnect::params::package_name:
      ensure => $::openconnect::version,
    }
  } else {
    package { $openconnect::params::package_name:
      ensure => $ensure,
    }
  }

  if ! empty($openconnect::params::additional_packages) {
    package { $openconnect::params::additional_packages:
      ensure => $ensure,
    }
  }
}
