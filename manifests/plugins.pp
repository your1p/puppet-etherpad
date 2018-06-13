class etherpad::plugins ()
inherits ::etherpad {
#Génèse du fichier settings.json pour Etherpad#..#
  $myhash = {
              'loglevel'                 =>  "$etherpad::_hash_loglevel",
              'socketTransportProtocols' =>  "$etherpad::_hash_socket_transport_protocols",
              'loadTest'                 =>  "$etherpad::_hash_load_test",
              'indentationOnNewLine'     =>  "$etherpad::_hash_indentation_on_new_line",
              'disableIPlogging'         =>  "$etherpad::_hash_disable_ip_logging",
              'allowUnknownFileEnds'     =>  "$etherpad::_hash_allow_unknow_file_ends",
              'favicon'                  =>  "$etherpad::_hash_favicon",
              'title'                    =>  "$etherpad::_hash_pad_title",
              'ip'                       =>  "$etherpad::_hash_ip",
              'port'                     =>  "$etherpad::_hash_port",
              'padOptions'               =>  "$etherpad::_hash_padoptions",
              'requireSession'           =>  "$etherpad::_hash_require_session",
              'editOnly'                 =>  "$etherpad::_hash_edit_only",
              'minify'                   =>  "$etherpad::_hash_minify",
              'maxAge'                   =>  "$etherpad::_hash_max_age",
              'tidyHtml'                 =>  "$etherpad::_hash_tidy_path",
              'requireAuthentication'    =>  "$etherpad::_hash_require_authentication",
              'requireAuthorization'     =>  "$etherpad::_hash_require_authorization",
              'trustProxy'               =>  "$etherpad::_hash_trust_proxy",
              'users'                    =>  "$etherpad::_hash_users",
              'toolbar'                  =>  "$etherpad::_hash_toolbar",
              'logconfig'                =>  "$etherpad::_hash_logconfig",
              'ssl'                      =>  "$etherpad::_hash_ssl",
              'dbSettings'               =>  "$etherpad::_hash_dbsettings",
              'abiword'                  =>  "$etherpad::_hash_manage_abiword",
  }

file { '/tmp/new-settings.json':
      ensure    => file,
        content => to_json_pretty($myhash),
  }
  notice("to_json_pretty : $myhash")
}
