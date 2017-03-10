# create service definition for etherpad for upstart
class etherpad::service::debian {
  file { '/etc/init.d/etherpad':
    ensure  => 'file',
    owner   => 'root',
    mode    => '0755',
    content => epp("${module_name}/service/debian.epp"),
  }
}
