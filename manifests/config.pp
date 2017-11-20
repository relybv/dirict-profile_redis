# == Class profile_redis::config
#
# This class is called from profile_redis for service config.
#
class profile_redis::config {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }
}
