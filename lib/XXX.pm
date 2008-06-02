package XXX;
use 5.006001;
use strict;
use warnings;
no warnings 'redefine';
use base 'Exporter';

{
    no strict 'refs';
    *{"YYY::"} = *{"XXX::"};
}

our $VERSION = '0.11';
our @EXPORT = qw( WWW XXX YYY ZZZ );

my $dump = 'yaml';

sub import {
    my ($package, @args) = @_;
    for my $arg (@args) {
        $dump = 'dumper'
          if $arg =~ /^-dumper$/i;
        $dump = 'yaml'
          if $arg =~ /^-yaml$/i;
    }
    @_ = ($package);
    goto &Exporter::import;
}

sub _xxx_dump {
    no warnings;
    if ($dump eq 'dumper') {
        require Data::Dumper;
        $Data::Dumper::Sortkeys = 1;
        $Data::Dumper::Indent = 1;
        return Data::Dumper::Dumper(@_);
    }
    require YAML;
    return YAML::Dump(@_) . "...\n";
}

sub _at_line_number {
    my ($file_path, $line_number) = (caller(1))[1,2];
    "  at $file_path line $line_number\n";
}

sub WWW {
    warn _xxx_dump(@_) . _at_line_number;
    return wantarray ? @_ : $_[0];
}

sub XXX {
    die _xxx_dump(@_) . _at_line_number;
}

sub YYY {
    print _xxx_dump(@_) . _at_line_number;
    return wantarray ? @_ : $_[0];
}

sub ZZZ {
    require Carp;
    Carp::confess _xxx_dump(@_);
}

1;

=encoding utf8

=head1 NAME

XXX - See Your Data in the Nude

=head1 SYNOPSIS

    use XXX;
    XXX my $dog = Dog->new({has => ['fleas', 'style']});
    my $dog = XXX Dog->new({has => ['fleas', 'style']});
    my $dog = Dog->new(XXX {has => ['fleas', 'style']});
    my $dog = Dog->new({XXX has => ['fleas', 'style']});
    my $dog = Dog->new({has => XXX ['fleas', 'style']});
    my $dog = Dog->new({has => [XXX 'fleas', 'style']});

=head1 DESCRIPTION

XXX.pm exports a function called XXX that you can put just about
anywhere in your Perl code to make it die with a YAML dump of the
arguments to its right.

The charm of XXX-debugging is that it is easy to type and rarely
requires parens and stands out visually so that you remember to
remove it.

XXX.pm also exports WWW, YYY and ZZZ which do similar debugging things.

To use Data::Dumper instead of YAML:

    use XXX -dumper;

=head1 FUNCTIONS

=over

=item WWW

WWW will warn a dump of its arguments, and then return the original
arguments. This means you can stick it in the middle of expressions.

mnemonic: W for warn

=item XXX

XXX will die with a dump of its arguments.

mnemonic: XXX == Death, Nudity

=item YYY

YYY will print a dump of its arguments, and then return the original
arguments. This means you can stick it in the middle of expressions.

mnemonic: YYY == Why Why Why??? or YAML YAML YAML

=item ZZZ

ZZZ will Carp::confess a dump of its arguments.

mnemonic: You should confess all your sins before you sleep. zzzzzzzz

=back

=head1 NOTE FOR INSTALLING XXX

At this time CPAN indexes XXX.pm to some other module distribution that
doesn't even have an XXX.pm module. Oh the wonders of CPAN. To install
this module, ask for YYY.pm instead. Something like this should work:

    sudo cpan YYY

This will install XXX.pm and YYY.pm (which is an exact copy of XXX.pm).
You can use either one. :)

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2006, 2008. Ingy döt Net.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut
