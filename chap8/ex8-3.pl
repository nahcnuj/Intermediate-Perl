#!/usr/bin/env perl

use strict;
use warnings;

for (@ARGV) {
    unless (-d) {
        warn "$_ is not a directory.\n";
        next;
    }

    opendir my $dh, $_ or die "Could not open $_: $!";
    print "$_\n" for sort readdir $dh;
}

