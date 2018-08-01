# == Class etherpad::config
#
# This class is called from etherpad for service config.
#
class etherpad::config {

  $ensure = $::etherpad::ensure ? {
    'absent' => 'absent',
    default  => 'present',
  }

  concat {"${::etherpad::root_dir}/settings.json":
    ensure  => $ensure,
    owner   => $::etherpad::user,
    group   => $::etherpad::group,
  }

  concat::fragment{ 'settings.json.epp':
    target  => "${::etherpad::root_dir}/settings.json",
    content => epp("${module_name}/settings.json.epp"),
    order   => '01',
  }
}
