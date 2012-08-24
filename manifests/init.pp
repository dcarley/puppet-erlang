# == Class: erlang
#
# Installs Erlang runtime.
#
# Pulls in EPEL for EL based OSs.
#
# === Parameters
#
# [*package_ensure*]
#   Override ensure=>present on the package.
#
# [*package_name*]
#   Override the package name.
#
# [*package_require*]
#   Override the package dependencies.
#
# === Variables
#
# === Examples
#
#   include ::erlang
#
#   class { 'erlang':
#     package_name    => 'erlang-base',
#     package_require => '',
#   }
#
class erlang (
  $package_ensure   = $::erlang::params::package_ensure,
  $package_name     = $::erlang::params::package_name,
  $package_require  = $::erlang::params::package_require
) inherits erlang::params {
  package { 'erlang':
    ensure  => $package_ensure,
    name    => $package_name,
    require => $package_require,
  }
}
