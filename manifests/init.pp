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
  Boolean $manage_abiword                    = false,
  Stdlib::Absolutepath $abiword_path         = '/usr/bin/abiword',
  Boolean $manage_tidy                       = false,
  Stdlib::Absolutepath  $tidy_path           = '/usr/bin/tidy',
  String  $user                              = 'etherpad',
  String  $group                             = 'etherpad',
  Stdlib::Absolutepath $root_dir             = '/opt/etherpad',
  String  $source                            = 'https://github.com/ether/etherpad-lite.git',

  # Db
  Enum['dirty', 'mysql', 'sqlite', 'postgres'] $database_type = 'dirty',
  String $database_host                                       = 'localhost',
  String $database_user                                       = 'etherpad',
  String $database_name                                       = 'etherpad',
  String $database_password                                   = 'etherpad',

  # Network
  Optional[String] $ip = undef,
  Integer $port        = 9001,
  Boolean $trust_proxy = false,

  # Performance
  Integer $max_age = 21600,
  Boolean $minify  = true,

  # Config
  Optional[Hash] $ldapauth        = undef,
  Optional[Hash] $button_link     = undef,
  Boolean $require_session        = false,
  Boolean $edit_only              = false,
  Boolean $require_authentication = false,
  Boolean $require_authorization  = false,
  Optional[String]  $pad_title    = undef,
  String $default_pad_text        = 'Welcome to etherpad!',

  # Users
  Optional[Hash] $users = undef,

  # Ssl
  Enum['enable','disable'] $ssl  = 'disable',
  Stdlib::Absolutepath $ssl_key  = '/etc/ssl/epad/epl-server.key',
  Stdlib::Absolutepath $ssl_cert = '/etc/ssl/epad/epl-server.crt',

  # Logging
  Boolean $logconfig_file                        = false,
  Optional[String] $logconfig_file_filename      = undef,
  Optional[Integer] $logconfig_file_max_log_size = undef,
  Optional[Integer] $logconfig_file_backups      = undef,
  Optional[String] $logconfig_file_category      = undef,

  # Padoptions
  Optional[Hash[Enum['nocolors',
  'showcontrols',
  'showchat',
  'showlinenumbers',
  'usemonospacefont',
  'username',
  'usercolor',
  'rtl',
  'alwaysshowchat',
  'chatandusers',
  'lang',
  ], String]] $padoptions = undef,
) inherits ::etherpad::params {
  #Merged values provides by user and default values
  if $padoptions {
    $_real_padoptions = merge($etherpad::params::default_padoptions, $etherpad::padoptions)
  } else {
    $_real_padoptions = $etherpad::params::default_padoptions
  }
notice("final hash : $_real_padoptions")
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
}
