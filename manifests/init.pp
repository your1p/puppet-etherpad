# Class: etherpad
# ===============
#
# The etherpad module installs and configures etherpad.
# This class is the entry point for the module and the configuration point.
#
class etherpad (
  # General
  Etherpad::Ensure $ensure                   = 'present', # This should be a pattern, but right now that's too long
  String $service_name                       = 'etherpad',
  Enum['running', 'stopped'] $service_ensure = 'running', # again, should be an enum…
  # what if the fact doesn't exist (yet) or is b0rked? use Optional.
  Optional[String] $service_provider         = $::service_provider,
  Boolean $manage_user                       = true,
  Optional[Hash] $manage_abiword             = undef,
  Boolean $manage_tidy                       = false,
  Optional[Hash]  $tidy_path                 = undef,
  String  $user                              = 'etherpad',
  String  $group                             = 'etherpad',
  Stdlib::Absolutepath $root_dir             = '/opt/etherpad',
  String  $source                            = 'https://github.com/ether/etherpad-lite.git',
  Optional[Hash] $loglevel                   = undef,
  Optional[Hash] $socket_transport_protocols = undef,
  Optional[Hash] $load_test                  = undef,
  Optional[Hash] $indentation_on_new_line    = undef,
  Optional[Hash] $disable_ip_logging         = undef,
  Optional[Hash] $allow_unknow_file_ends     = undef,
  Optional[Hash] $tidy_html                  = undef,
  Optional[Hash] $toolbar                    = undef,
  Optional[Hash] $favicon                    = undef,

  # Db
  Optional[Etherpad::Database] $db_settings = undef,

  # Network
  Optional[Hash] $ip          = undef,
  Optional[Hash] $port        = undef,
  Optional[Hash] $trust_proxy = undef,

  # Performance
  Optional[Hash] $max_age = undef,
  Optional[Hash] $minify  = undef,

  # Config
  Optional[Hash] $ldapauth               = undef,
  Optional[Hash] $button_link            = undef,
  Optional[Hash] $require_session        = undef,
  Optional[Hash] $edit_only              = undef,
  Optional[Hash] $require_authentication = undef,
  Optional[Hash] $require_authorization  = undef,
  Optional[Hash] $pad_title              = undef,
  String $default_pad_text               = 'Welcome to etherpad!',

  # Users
  Optional[Hash] $users = undef,

  # Ssl
  Optional[Etherpad::Ssl] $ssl = undef,

  # Logging
  Boolean $logconfig_file                        = false,
  Optional[String] $logconfig_file_filename      = undef,
  Optional[Integer] $logconfig_file_max_log_size = undef,
  Optional[Integer] $logconfig_file_backups      = undef,
  Optional[String] $logconfig_file_category      = undef,

  # Padoptions
  Optional[Etherpad::Padoptions] $padoptions = undef,
) inherits ::etherpad::params {
  #Merged values provides by user and default values
  if $padoptions {
    $_hash_padoptions = merge($etherpad::params::default_padoptions, $etherpad::padoptions)
  } else {
    $_hash_padoptions = $etherpad::params::default_padoptions
  }

  if $users {
    $_hash_users = merge($etherpad::params::default_users, $etherpad::users)
  } else {
    $_hash_users = $etherpad::params::default_users
  }

  if $ssl {
    $_hash_ssl = merge($etherpad::params::default_ssl, $etherpad::ssl)
  } else {
    $_hash_ssl = { }
  }

  if $db_settings {
    $_hash_dbsettings = merge($etherpad::params::default_dbsettings_rdbms, $etherpad::db_settings)
  } else {
    $_hash_dbsettings = $etherpad::params::default_dbsettings_sqlite
  }

  if $manage_abiword {
    $_hash_manage_abiword = merge($etherpad::params::default_manage_abiword, $etherpad::manage_abiword)
  } else {
    $_hash_manage_abiword = $etherpad::params::default_manage_abiword
  }

  if $logconfig_file {
    $_hash_logconfig = merge($etherpad::params::default_logconfig, $etherpad::logconfig_file)
  } else {
    $_hash_logconfig = { }
  }

  if $toolbar {
    $_hash_toolbar = merge($etherpad::params::default_toolbar, $etherpad::toolbar)
  } else {
    $_hash_toolbar = $etherpad::params::default_toolbar
  }

  if $pad_title {
    $_hash_title = merge($etherpad::params::default_pad_title, $etherpad::pad_title)
  } else {
    $_hash_title = $etherpad::params::default_pad_title
  }

  if $favicon {
    $_hash_favicon = merge($etherpad::params::default_favicon, $etherpad::favicon)
  } else {
    $_hash_favicon = $etherpad::params::default_favicon
  }

  if $loglevel {
    $_hash_loglevel = merge($etherpad::params::default_loglevel, $etherpad::loglevel)
  } else {
    $_hash_loglevel = $etherpad::params::default_loglevel
  }

  if $socket_transport_protocols {
    $_hash_socket_transport_protocols = merge($etherpad::params::default_socket_transport_protocols, $etherpad::socket_transport_protocols)
  } else {
    $_hash_socket_transport_protocols = $etherpad::params::default_socket_transport_protocols
  }

  if $indentation_on_new_line {
    $_hash_indentation_on_new_line = merge($etherpad::params::default_indentation_on_new_line, $etherpad::indentation_on_new_line)
  } else {
    $_hash_indentation_on_new_line = $etherpad::params::default_indentation_on_new_line
  }

  if $disable_ip_logging {
    $_hash_disable_ip_logging = merge($etherpad::params::default_disable_ip_logging, $etherpad::disable_ip_logging)
  } else {
    $_hash_disable_ip_logging = $etherpad::params::default_disable_ip_logging
  }

  if $allow_unknow_file_ends {
    $_hash_allow_unknow_file_ends = merge($etherpad::params::default_allow_unknow_file_ends, $etherpad::allow_unknow_file_ends)
  } else {
    $_hash_allow_unknow_file_ends = $etherpad::params::default_allow_unknow_file_ends
  }

  if $pad_title {
    $_hash_pad_title = merge($etherpad::params::default_pad_title, $etherpad::pad_title)
  } else {
    $_hash_pad_title = $etherpad::params::default_pad_title
  }

  if $ip {
    $_hash_ip = merge($etherpad::params::default_ip, $etherpad::ip)
  } else {
    $_hash_ip = $etherpad::params::default_ip
  }

  if $port {
    $_hash_port = merge($etherpad::params::default_port, $etherpad::port)
  } else {
    $_hash_port = $etherpad::params::default_port
  }

  if $require_session {
    $_hash_require_session = merge($etherpad::params::default_require_session, $etherpad::require_session)
  } else {
    $_hash_require_session = $etherpad::params::default_require_session
  }

  if $edit_only {
    $_hash_edit_only = merge($etherpad::params::default_edit_only, $etherpad::edit_only)
  } else {
    $_hash_edit_only = $etherpad::params::default_edit_only
  }

  if $minify {
    $_hash_minify = merge($etherpad::params::default_minify, $etherpad::minify)
  } else {
    $_hash_minify = $etherpad::params::default_minify
  }

  if $max_age {
    $_hash_max_age = merge($etherpad::params::default_max_age, $etherpad::max_age)
  } else {
    $_hash_max_age = $etherpad::params::default_max_age
  }

  if $tidy_path {
    $_hash_tidy_path = merge($etherpad::params::default_tidy_path, $etherpad::tidy_path)
  } else {
    $_hash_tidy_path = $etherpad::params::default_tidy_path
  }

  if $require_authentication {
    $_hash_require_authentication = merge($etherpad::params::default_require_authentication, $etherpad::require_authentication)
  } else {
    $_hash_require_authentication = $etherpad::params::default_require_authentication
  }

  if $require_authorization {
    $_hash_require_authorization = merge($etherpad::params::default_require_authorization, $etherpad::require_authorization)
  } else {
    $_hash_require_authorization = $etherpad::params::default_require_authorization
  }

  if $trust_proxy {
    $_hash_trust_proxy = merge($etherpad::params::default_trust_proxy, $etherpad::trust_proxy)
  } else {
    $_hash_trust_proxy = $etherpad::params::default_trust_proxy
  }

  if $load_test {
    $_hash_load_test = merge($etherpad::params::default_load_test, $etherpad::load_test)
  } else {
    $_hash_load_test = $etherpad::params::default_load_test
  }

  contain '::etherpad::plugins'
  if $manage_user {
    contain '::etherpad::user'

    Class['etherpad::user']
    -> Class['etherpad::install']
  }

  contain '::etherpad::install'
  contain '::etherpad::config'
  contain '::etherpad::service'

  Class['etherpad::install']
  -> Class['etherpad::config']
  ~> Class['etherpad::service']

  Class['etherpad::install']
  ~> Class['etherpad::service']

notify{"db : $_hash_dbsettings":}
notify{"users : $_hash_users":}
notify{"ssl : $_hash_ssl":}
notify{"padoptions : $_hash_padoptions":}
}
