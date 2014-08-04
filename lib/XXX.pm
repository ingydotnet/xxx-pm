use strict; use warnings;
package XXX;
our $VERSION = '0.24';
use base 'Exporter';

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
    my ($file_path, $line_number);
    my $caller = 0;
    while (++$caller) {
        no strict 'refs';
        my $skipper = (caller($caller))[0] . "::XXX_skip";
        next if defined &$skipper and &$skipper();
        ($file_path, $line_number) = (caller($caller))[1,2];
        last;
    }
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
