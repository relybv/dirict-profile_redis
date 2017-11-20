# == Class profile_redis::config
#
# This class is called from profile_redis for service config.
#
class profile_redis::config {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  file_line { 'change_bindaddress':
    path  => '/etc/redis/redis.conf',
    line  => '# bind 127.0.0.1',
    match => '^bind 127.0.0.1.*$',
  }
}
