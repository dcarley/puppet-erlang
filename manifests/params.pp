# == Class: erlang::params
#
# Configure variables for Erlang installation.
#
# - RHEL-alike: Pulls in EPEL for the package.
# - Debian-alike: Uses the slimmer erlang-nox package.
#
# === Parameters
#
# === Variables
#
# === Examples
#
class erlang::params {
  $package_ensure = present

  case $::osfamily {
    'RedHat': {
      include ::epel
      $package_name     = 'erlang'
      $package_require  = Class['epel']
    }
    'Debian': {
      $package_name     = 'erlang-nox'
      $package_require  = undef
    }
    default: {
      # Catch Debian Squeeze which doesn't have osfamily from Facter 1.6
      case $::operatingsystem {
        'Debian': {
          $package_name     = 'erlang-nox'
          $package_require  = undef
        }
        default: {
          fail("Module ${module_name} does not support ${::operatingsystem}")
        }
      }
    }
  }
}
