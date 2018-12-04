use strict;
use warnings;

use Test::More;

my $json_color = eval "use JSON::Color; 1";
unless ($json_color) {
    plan skip_all => "JSON::Color not installed";
    exit;
}

plan tests => 1;

my $data = { key => 'value' };

$ENV{PERL_XXX_DUMPER} = 'JSON::Color';
require XXX;

my $json = JSON::Color::encode_json($data);
eval { XXX::XXX($data) };
my $error = $@;
like ( $error, qr{\A\Q$json}, 'contains colored JSON' );
