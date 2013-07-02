# == Class openconnect::intall
#
class openconnect::install {
  include openconnect::params

  package { $openconnect::params::package_name:
    ensure => present,
  }
}
