#!/usr/bin/env perl

use v5.10;
use strict;
use warnings;

use Data::Dumper;

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
    my ($path, $data_ref) = @_;

    if (not defined $data_ref) {
        # file or symbolic link
        print "$path\n";
    } else {
        print "$path\n";
        dump_data_for_path("$path/$_", $data_ref->{$_}) for sort keys %$data_ref;
    }
}

print dump_data_for_path('.', data_for_path('.'));

