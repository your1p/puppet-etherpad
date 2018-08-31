define etherpad::plugins::common (
  String[1] $plugin_name = $title,
  $valid_plugin_name = assert_type(String[1], $title),
  ) {
    include nodejs
    nodejs::npm { $valid_plugin_name :
      ensure => 'present',
      target => "${etherpad::root_dir}/",
    }
    ->file { $valid_plugin_name :
      ensure => directory,
      path   => "${etherpad::root_dir}/node_modules/${valid_plugin_name}",
      owner  => $etherpad::user,
      group  => $etherpad::group,
      notify => Service[$etherpad::service_name],
    }
  }
