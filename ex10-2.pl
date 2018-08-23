#!/usr/bin/env perl

use strict;
use warnings;

use Benchmark qw(:all);

cmpthese(-1, {
    'before' => sub {
        chdir;
        my @sorted =
            sort { -s $a <=> -s $b }
            glob '*';
    },
    'after' => sub {
        chdir;
        my @sorted =
            map { $_->{ORIGINAL} }
            sort { $a->{FOLDED} <=> $b->{FOLDED} }
            map { ORIGINAL => $_, FOLDED => -s $_ },
            glob '*';
    },
});
