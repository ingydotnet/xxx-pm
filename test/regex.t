use strict;
use warnings;

use Data::Dumper;
use Test::More tests => 2;

my $str = "bug";
$str =~ m/(b)(u)(g)/x;

use XXX;

eval { XXX \@+; };
like ( $@, qr/3.+1.+2.+3/s, 'XXX has the string' );

eval { die Dumper \@+; };
like ( $@, qr/3.+1.+2.+3/s, 'Dumper has the string' );
