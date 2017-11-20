# == Class: profile_redis
#
# Full description of class profile_redis here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.

class profile_redis(
  ) inherits ::profile_redis::params {

  class { '::profile_redis::install': }
  -> class { '::profile_redis::config': }
  ~> class { '::profile_redis::service': }
  -> Class['::profile_redis']
}
