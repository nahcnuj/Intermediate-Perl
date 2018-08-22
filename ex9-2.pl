#!/usr/bin/env perl

use strict;
use warnings;

my @patterns = map {
    chomp;
    eval { qr/$_/ }
        or do {
            warn "Pattern /$_/ is invalid. Skipping...";
            next;
        }
} <>;

print "Enter lines (Ctrl-D to end):\n";
while (my $line = <STDIN>) {
    if (my @matched_patterns = grep { $line =~ $_ } @patterns) {
        print map { "Match of $_ at line $. | $line" } @matched_patterns;
    }
}
