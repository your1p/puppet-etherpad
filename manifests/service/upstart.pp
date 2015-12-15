# create service definition for etherpad for upstart
class etherpad::service::upstart {

  file { '/etc/init/etherpad.conf':
    ensure  => 'file',
    content => epp("${module_name}/service/upstart.epp"),
  }

  file { '/etc/init.d/etherpad':
    ensure => 'link',
    target => '/lib/init/upstart-job',
  }
}
