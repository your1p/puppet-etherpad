define etherpad::plugins::common (
  $plugin_name = "$title",
  ) {
    nodejs::npm { $plugin_name :
      ensure => 'present',
      target => "${etherpad::root_dir}/",
    }
    ->file { $plugin_name :
      path    => "${etherpad::root_dir}/node_modules/${plugin_name}",
      ensure  => directory,
      owner   => "$etherpad::user",
      group   => "$etherpad::group",
      notify  => Service["$etherpad::service_name"],
    }
  }
