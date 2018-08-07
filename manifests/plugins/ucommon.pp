define etherpad::plugins::ucommon (
  $plugin_name = "$title",
  ) {
    nodejs::npm { "Uninstall $plugin_name" :
      ensure  => 'absent',
      package => "$plugin_name" ,
      target  => "${etherpad::root_dir}/node_modules/",
    }
    ->file { $plugin_name :
      path    => "${etherpad::root_dir}/node_modules/${plugin_name}",
      ensure  => absent,
      recurse => true,
      force   => true,
      notify  => Service["$etherpad::service_name"],
    }
    ->Service[$etherpad::service_name]
}
