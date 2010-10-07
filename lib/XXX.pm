package XXX;
use 5.006001;
use strict;
use warnings;
use base 'Exporter';

our $VERSION = '0.17';
our @EXPORT = qw( WWW XXX YYY ZZZ );

our $DumpModule = 'YAML';

sub import {
    my ($package, @args) = @_;
    for (my $i = 0; $i < @args; $i++) {
        my $arg = $args[$i];
        if ($arg eq '-with') {
            die "-with requires another argument"
              unless $i++ < @args;
            $DumpModule = $args[$i];
            die "Don't know how to use XXX -with '$DumpModule'"
                unless $DumpModule =~ /^(YAML|Data::Dumper$)/;
        }
        # TODO Deprecation. These options are now undocumented. Next releases:
        # warn, then die, then remove.
        elsif ($arg =~ /^-dumper$/i) {
            $DumpModule = 'Data::Dumper';
        }
        elsif ($arg =~ /^-yaml$/i) {
            $DumpModule = 'YAML';
        }
        else {
            next;
        }
        last;
    }
    @_ = ($package);
    goto &Exporter::import;
}

sub _xxx_dump {
    no strict 'refs';
    no warnings;
    $DumpModule ||= 'YAML';
    my $dump_type =
        ($DumpModule =~ /^YAML/) ? 'yaml' :
        ($DumpModule eq 'Data::Dumper') ? 'dumper' :
        die 'Invalid dump module in $DumpModule';
    if (not defined ${"$DumpModule\::VERSION"}) {
        eval "require $DumpModule; 1" or die $@;
    }
    if ($dump_type eq 'yaml') {
        return &{"$DumpModule\::Dump"}(@_) . "...\n";
    }
    elsif ($dump_type eq 'dumper') {
        local $Data::Dumper::Sortkeys = 1;
        local $Data::Dumper::Indent = 2;
        return Data::Dumper::Dumper(@_);
    }
    else {
        die "XXX had an internal error";
    }
}

sub _at_line_number {
    my ($file_path, $line_number) = (caller(1))[1,2];
    "  at $file_path line $line_number\n";
}

sub WWW {
    my $dump = _xxx_dump(@_) . _at_line_number();
    if (defined &main::diag and
        defined &Test::More::diag and
        \&main::diag eq \&Test::More::diag
    ) {
        main::diag($dump);
    }
    else {
        warn($dump);
    }
    return wantarray ? @_ : $_[0];
}

sub XXX {
    die _xxx_dump(@_) . _at_line_number();
}

sub YYY {
    my $dump = _xxx_dump(@_) . _at_line_number();
    if (defined &main::note and
        defined &Test::More::note and
        \&main::note eq \&Test::More::note
    ) {
        main::note($dump);
    }
    else {
        print($dump);
    }
    return wantarray ? @_ : $_[0];
}

sub ZZZ {
    require Carp;
    Carp::confess(_xxx_dump(@_));
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

The charm of XXX-debugging is that it is easy to type, rarely requires
parens and stands out visually so that you remember to remove it.

XXX.pm also exports WWW, YYY and ZZZ which do similar debugging things.

=head1 FUNCTIONS

=over

=item WWW

WWW will warn a dump of its arguments, and then return the original
arguments. This means you can stick it in the middle of expressions.

NOTE: If you use WWW with Test::More, it will <diag()> rather than C<warn()>.

mnemonic: W for warn

=item XXX

XXX will die with a dump of its arguments.

mnemonic: XXX == Death, Nudity

=item YYY

YYY will print a dump of its arguments, and then return the original
arguments. This means you can stick it in the middle of expressions.

NOTE: If you use YYY with Test::More, it will <note()> rather than C<print()>.

mnemonic: YYY == Why Why Why??? or YAML YAML YAML

=item ZZZ

ZZZ will Carp::confess a dump of its arguments.

mnemonic: You should confess all your sins before you sleep. zzzzzzzz

=back

=head1 CONFIGURATION

By default, XXX uses YAML.pm to dump your data. You can change this like so:

    use XXX -with => 'Data::Dumper';
    use XXX -with => 'YAML::XS';
    use XXX -with => 'YAML::SomeOtherYamlModule';

Only modules with names beginning with 'YAML' and the Data::Dumper
module are supported.

If you need to load XXX with C<require>, you can set the dumper module
with the C<$XXX::DumpModule> global variable.

    require XXX;
    $XXX::DumpModule = 'YAML::Syck';
    
    XXX::XXX($variable);

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2006, 2008, 2010. Ingy döt Net.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut
