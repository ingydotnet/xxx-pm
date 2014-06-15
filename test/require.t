use Test::More tests => 2;

require XXX;

eval { XXX::XXX([1, 2]) };

like $@, qr/^---/, 'YAML Dump Worked for "require XXX"';

no warnings 'once';
$XXX::DumpModule = 'Data::Dumper';

eval { XXX::XXX([1, 2]) };

like $@, qr/^\$VAR/, 'YAML Dump Worked with $DumpModule';
