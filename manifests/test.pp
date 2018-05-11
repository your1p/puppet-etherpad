$hash1 = {'nocolors' => 'false','lang' => 'eng-gb', 'rtl' => 'false'}
$hash2 = {'nocolors' => 'true', 'lang' => 'fr'}
$merged_hash = merge($hash1, $hash2)
notice("test :$merged_hash")
