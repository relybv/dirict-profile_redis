# == Class profile_redis::params
#
# This class is meant to be called from profile_redis.
# It sets variables according to platform.
#

class profile_redis::params {

  case $::osfamily {
    'Debian': {
      $package_name = 'redis-server'
      $service_name = 'redis-server'
    }
    'RedHat', 'Amazon': {
      $package_name = 'redis-server'
      $service_name = 'redis-server'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
