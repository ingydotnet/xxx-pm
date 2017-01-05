use strict;
use warnings;

use v5.10;

use Data::Dumper;
use Test::More tests => 4;

my $str = "bug";
$str =~ m/(?<first>[a-z]*)/x;

use XXX;

eval { XXX \%+; };
like ( $@, qr/bug/, 'has the string' );
like ( $@, qr/first/, 'has the capture pattern' );

eval { die Dumper \%+; };
like ( $@, qr/bug/, 'has the string' );
like ( $@, qr/first/, 'has the capture pattern' );
