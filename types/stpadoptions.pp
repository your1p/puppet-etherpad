# Matches Pad Options Keys And Values
type Etherpad::Stpadoptions = Hash[Enum[
    'noColors',        
    'showControls',    
    'showLineNumbers', 
    'useMonospaceFont',
    'userName', 
    'userColor',       
    'rtl',       
    'alwaysShowChat',
    'chatAndUsers',  
    'lang',
], Variant[Boolean, String]]
