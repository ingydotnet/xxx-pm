use Test::More tests => 1;

use XXX -with => 'Data::Dumper';

sub foo {
    XXX my $dog = Dog->new({has => ['fleas', 'style']});
    my $dog1 = WWW Dog->new({has => ['fleas', 'style']});
    my $dog2 = Dog->new(YYY {has => ['fleas', 'style']});
    my $dog3 = Dog->new({ZZZ has => ['fleas', 'style']});
    my $dog4 = Dog->new({has => XXX ['fleas', 'style']});
    my $dog5 = Dog->new({has => [XXX 'fleas', 'style']});
}

pass 'Everything compiled';
