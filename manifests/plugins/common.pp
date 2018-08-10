define etherpad::plugins::common (
  $plugin_name = $title,
  ) {
    include nodejs
    nodejs::npm { $plugin_name :
      ensure => 'present',
      target => "${etherpad::root_dir}/",
    }
    ->file { $plugin_name :
      ensure => directory,
      path   => "${etherpad::root_dir}/node_modules/${plugin_name}",
      owner  => $etherpad::user,
      group  => $etherpad::group,
      notify => Service[$etherpad::service_name],
    }
  }
