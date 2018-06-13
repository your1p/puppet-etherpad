class etherpad::params {
  $default_padoptions = {
    'nocolors'         => 'false',
    'showcontrols'     => 'true',
    'showchat'         => 'true',
    'showlinenumbers'  => 'true',
    'usemonospacefont' => 'false',
    'username'         => 'false',
    'usercolor'        => 'false',
    'rtl'              => 'false',
    'alwaysshowchat'   => 'false',
    'chatandusers'     => 'false',
    'lang'             => 'en-gb',
  }
  $default_users = {
    'user'       => {
      'password' => 'changeme1',
      'is_admin' => 'false',
    },
    'admin'      => {
      'password' => 'changeme1',
      'is_admin' => 'true',
    }
  }

  $default_ssl = {
      'key'  => '/etc/ssl/epad/epl-server.key',
      'cert' => '/etc/ssl/epad/epl-server.crt',
  }
  $default_dbsettings_sqlite = {
    'filename' => 'var/dirty.db',
  }
  $default_dbsettings_rdbms = {
      'user'     => 'etherpad',
      'host'     => 'localhost',
      'password' => 'etherpad',
      'database' => 'etherpad',
  }
  $default_manage_abiword = {
    'abiword' => 'null',
  }
  $default_logconfig = {
    'type'       => 'file',
    'filename'   => 'myfilename',
    'file'       => 'your-log-file-here.log',
    'maxLogSize' => '1024',
    'backups'    => '3',
  }
  $default_pad_title = {
    'title' => 'pad_title',
  }
  $default_favicon = {
    'favicon' => 'favicon.ico',
  }
  $default_ip = {
  'ip' => '0.0.0.0',
  }
  $default_port = {
  'ip' => '9001',
  }
  $default_padtext = {
    'defaultPadText' => 'Welcome to etherpad!',
  }
  $default_error_suppress = {
    'suppressErrorInPadText' => 'false',
  }
  $default_require_session = {
    'requireSession' => 'false',
  }
  $default_edit_only = {
    'editOnly' => 'false',
  }
  $default_sessionNoPassword = {
    'sessionNoPassword' => 'false',
  }
  $default_minify = {
    'minify' => 'true',
  }
  $default_max_age = {
    'maxAge' => '21600',
  }
  $default_soffice = {
    'soffice' => 'null',
  }
  $default_tidy_path = {
    'tidyHtml' => '/usr/bin/tidy',
  }
  $default_allow_unknow_file_ends = {
    'allowUnknowFileEnds' => 'true',
  }
  $default_require_authorization = {
    'requireAuthorization' => 'false',
  }
  $default_require_authentication = {
    'requireAuthentication' => 'false',
  }
  $default_trust_proxy = {
    'trustProxy' => 'false',
  }
  $default_disable_ip_logging = {
    'disableIPlogging' => 'false',
  }
  $default_socket_transport_protocols = {
    'socketTransportProtocols' => ['xhr-polling','jsonp-polling','htmlfile'],
  }
  $default_load_test = {
    'loadtest' => 'false',
  }
  $default_indentation_on_new_line = {
    'indentationOnNewLine' => 'false',
  }
  $default_toolbar = {
      'left'  => [
        ['bold','italic','underline','strikethrough'],
        ['orderedlist', 'unorderedlist', 'indent', 'outdent'],
        ['undo', 'redo'],
        ['clearauthorship']
      ],
      'right' => [
        ['importexport', 'timeslider', 'savedrevision'],
        ['settings', 'embed'],
        ['showusers']
      ],
      'timeslider' => [
        ['timeslider_export', 'timeslider_returnToPad']
      ]
  }
  $default_loglevel = {
    'loglevel' => 'INFO',
  }
}
