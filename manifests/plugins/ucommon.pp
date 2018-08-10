define etherpad::plugins::ucommon (
  $plugin_name = $title,
  ) {
    nodejs::npm { $plugin_name :
      ensure => 'absent',
      target => "${etherpad::root_dir}/node_modules/",
    }
    ->file { $plugin_name :
      ensure  => absent,
      path    => "${etherpad::root_dir}/node_modules/${plugin_name}",
      recurse => true,
      force   => true,
      notify  => Service[$etherpad::service_name],
    }
  }
