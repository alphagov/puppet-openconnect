# == Class openconnect::install
#
# Install OpenConnect and vpnc (required for vpnc-script).
#
class openconnect::install {
  include openconnect::params

  package { $openconnect::params::package_name:
    ensure => $::openconnect::version,
  }

  if ! empty($openconnect::params::additional_packages) {
    package { $openconnect::params::additional_packages:
      ensure => present,
    }
  }
}
