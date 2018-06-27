# Matches Pad Options Keys And Values
type Etherpad::Stpadoptions = Struct[
  {
    Optional['nocolors']         => Variant[Boolean, String],
    Optional['showcontrols']     => Variant[Boolean, String],
    Optional['showlinenumbers']  => Variant[Boolean, String],
    Optional['usemonospacefont'] => Variant[Boolean, String],
    Optional['username']         => Variant[Boolean, String],
    Optional['usercolor']        => Variant[Boolean, String],
    Optional['rtl']              => Variant[Boolean, String],
    Optional['alwaysshowchat']   => Variant[Boolean, String],
    Optional['chatandusers']     => Variant[Boolean, String],
    Optional['lang']             => String[1],
  }
]
