# == Class: openconnect
#
# Full description of class openconnect here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class openconnect (
) inherits openconnect::params {

  # validate parameters here

  anchor { 'openconnect::begin': } ->
  class { 'openconnect::install': } ->
  class { 'openconnect::config': }
  class { 'openconnect::service': } ->
  anchor { 'openconnect::end': }

  Anchor['openconnect::begin']  ~> Class['openconnect::service']
  Class['openconnect::install'] ~> Class['openconnect::service']
  Class['openconnect::config']  ~> Class['openconnect::service']
}
