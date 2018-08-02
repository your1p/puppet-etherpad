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
  Etherpad::Ldapauth $ldapauth      = {},
  Etherpad::Buttonlink $button_link = {},
  Boolean $require_session          = false,
  Boolean $edit_only                = false,
  Boolean $require_authentication   = false,
  Boolean $require_authorization    = false,
  Optional[String]  $pad_title      = undef,
  String $default_pad_text          = 'Welcome to etherpad!',

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
  Etherpad::Padoptions $padoptions = {},

  # Plugins
  Hash[Pattern['ep_*'], Boolean] $plugins_list = {},
) {
  $default_padoptions = {
    noColors         => false,
    showControls     => true,
    showChat         => true,
    showLineNumbers  => true,
    useMonospaceFont => false,
    userName         => false,
    userColor        => false,
    rtl              => false,
    alwaysShowChat   => false,
    chatAndUsers     => false,
    lang             => 'en-gb',
  }
  #Merged values provides by user and default values
  $_real_padoptions = merge($default_padoptions, $padoptions)

  #Install choosing plugins
  $plugins_list.each |String $_pname, Boolean $_penable| {
  if $_penable == true {
    contain "etherpad::plugins::${_pname}"
    Class["etherpad::plugins::${_pname}"]
  } elsif $_penable == false {
    etherpad::plugins::common { "$_pname" :
    }
  } else {
    fail("The plugin $_pname is not supported yet. Please, check the plugins list before install a complex plugin")
  } notice("$_pname")
  }

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
