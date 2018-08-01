define etherpad::plugins::common ($_panme = $name)
{
  nodejs::npm { "$name" :
    ensure => 'present',
    target => "${etherpad::root_dir}/node_modules/",
  }
  concat::fragment{"$name":
    target  => "${etherpad::root_dir}/settings.json",
    content => epp("etherpad/plugins/${name}.epp"),
}
