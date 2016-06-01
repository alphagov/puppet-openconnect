# == Class openconnect::params
#
# This class is meant to be called from openconnect
# It sets variables according to platform
#
class openconnect::params {
  case $::osfamily {
    'Debian': {
      $package_name = ['vpnc', 'openconnect']
      $service_name = 'openconnect'
      $upstart      = true
    }
    'RedHat': {
      $package_name = ['openconnect']
      $service_name = 'openconnect'
      $upstart      = false
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
