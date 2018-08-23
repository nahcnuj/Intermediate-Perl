#!/usr/bin/env perl

use v5.10;
use strict;
use warnings;

use Data::Dumper;
use File::Basename;

sub data_for_path {
    my $path = shift;
    if (-f $path or -l $path) {
        undef;
    } elsif (-d $path) {
        my %directories;
        my @contents = do {
            opendir my $dh, $path or die "Could not open $path: $!";
            (readdir $dh);
        };
        +{ map {
            if ($_ ne '.' and $_ ne '..') {
                ($_ => data_for_path("$path/$_"))
            } else {
                ()
            }
        } @contents };
    } else {
        warn "$path is neither a file nor a dir\n";
        undef;
    }
}

sub dump_data_for_path {
    my ($path, $data_ref, $level) = @_;

    my $basename = basename $path;
    print '  ' x $level, $basename;
    if (not defined $data_ref) {
        # file or symbolic link
        print "\n";
    } elsif ( keys %$data_ref ) {
        print ", with contents:\n";
        dump_data_for_path("$path/$_", $data_ref->{$_}, 1+$level) for sort keys %$data_ref;
    } else {
        print ", an empty directory\n";
    }
}

print dump_data_for_path('.', data_for_path('.'), 0);

