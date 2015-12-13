# == Class etherpad::config
#
# This class is called from etherpad for service config.
#
class etherpad::config {

  $ensure = $::etherpad::ensure ? {
    'absent' => 'absent',
    default  => 'file',
  }

  file { "${::etherpad::root_dir}/settings.json":
    ensure  => $ensure,
    owner   => $::etherpad::user,
    group   => $::etherpad::group,
    content => epp("${module_name}/settings.json.epp"),
  }
}
