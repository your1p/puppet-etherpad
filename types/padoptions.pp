# Matches Pad Options Keys And Values
type Etherpad::Padoptions = Struct[
  {
    Optional['nocolors']         => String[1],
    Optional['showcontrols']     => String[1],
    Optional['showlinenumbers']  => String[1],
    Optional['usemonospacefont'] => String[1],
    Optional['username']         => String[1],
    Optional['usercolor']        => String[1],
    Optional['rtl']              => String[1],
    Optional['alwaysshowchat']   => String[1],
    Optional['chatandusers']     => String[1],
    Optional['lang']             => String[1],
  }
]
