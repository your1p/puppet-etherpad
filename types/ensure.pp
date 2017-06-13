type Etherpad::Ensure = Variant[Enum['present', 'latest', 'absent'], Pattern[/\A\d\.\d\.\d\Z/, /\A[a-fA-F0-9]{6,40}\Z/]]
