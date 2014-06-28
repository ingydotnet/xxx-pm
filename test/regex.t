use strict; use warnings;
use Test::More;

use XXX;

use Data::Dumper;

if ($] < 5.010000) {
    plan skip_all => "Skip on perl < 5.10";
}
else {
    plan tests => 4;
    eval "use v5.10; 1";
}

my $str = "bug";
$str =~ m/(?<first>[a-z]*)/x;

eval { XXX \%+; };
like ( $@, qr/bug/, 'has the string' );
like ( $@, qr/first/, 'has the capture pattern' );

eval { die Dumper \%+; };
like ( $@, qr/bug/, 'has the string' );
like ( $@, qr/first/, 'has the capture pattern' );
