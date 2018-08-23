#!/usr/bin/env perl

use strict;
use warnings;

chdir;
my @sorted =
    map { $_->{ORIGINAL} }
    sort { $a->{FOLDED} cmp $b->{FOLDED} }
    map {
        ORIGINAL => $_,
        FOLDED => do {
            my $s = $_;
            $s =~ tr/A-Z/a-z/;
            $s =~ tr/a-z//cd;
            $s;
        }},
    qw( abcd Professor skipper bcde Bazyx aafuga);

print "@sorted\n";
