define etherpad::plugins::common (
  $plugin_name = $title,
  ) {
  nodejs::npm { "$plugin_name" :
    ensure => 'present',
    target => "${etherpad::root_dir}/node_modules/",
  }
}
