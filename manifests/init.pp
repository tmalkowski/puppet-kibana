# == Class: kibana
#
# Full description of class kibana here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { kibana:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#
class kibana(
  $es_host      = $kibana::params::es_host,
  $es_port      = $kibana::params::es_port,
  $install_root = $kibana::params::install_root,
  $ldap_enable  = $kibana::params::ldap_enable,
  $version      = $kibana::params::version,
) inherits kibana::params {
  $install_dir = "${install_root}/kibana"
  class { 'kibana::install': } ->
  class { 'kibana::config': } ->
  Class['kibana']
}

# vim: set ts=2 sw=2 et ft=puppet:
