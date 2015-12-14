# create service definition for etherpad for systemd
class etherpad::service::systemd {

  file { '/lib/systemd/system/etherpad.service':
    ensure  => 'file',
    content => epp("${module_name}/service/systemd.epp"),
  }
}
