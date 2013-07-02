# == Class openconnect::service
#
# This class is meant to be called from openconnect
# It ensure the service is running
#
class openconnect::service {
  include openconnect::params

  service { $openconnect::params::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
