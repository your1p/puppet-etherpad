define etherpad::plugins::common($pname = $etherpad::_pname) {
  $supported_plugins = ['ep_button_link','ep_ldapauth']

  nodejs::npm { "$pname" :
    ensure => 'present',
    target => "${etherpad::root_dir}/node_modules/",
  }

  $supported_plugins.each |String $value| {
  if $value == $suppported_plugins {
    concat::fragment{"$value":
      target  => "${etherpad::root_dir}/settings.json",
      content => epp("etherpad/plugins/${value}.epp"),
    }
  } notice("kiki $name")
  } notice("$name")
}

