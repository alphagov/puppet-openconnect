# == Class openconnect::service
#
# This class is meant to be called from openconnect
# It ensure the service is running
#
class openconnect::service {
  include openconnect::params

  # Disable `hasrestart` because otherwise upstart won't pick up
  # option/argument changes to the init file.
  if $upstart {
    service { $openconnect::params::service_name:
      ensure     => running,
      enable     => true,
      hasstatus  => true,
      hasrestart => false,
      provider   => 'upstart',
    }
  }else{
    service { $openconnect::params::service_name:
      ensure     => running,
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
    }
  }
}
