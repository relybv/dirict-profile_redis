# == Class profile_redis::install
#
# This class is called from profile_redis for install.
#
class profile_redis::install {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  class { 'apt::backports':
    pin    => 500,
    notify => Exec['apt_update']
  }

  package { 'redis-server':
    ensure  => installed,
    require => Class['apt::backports'],
  }
}
