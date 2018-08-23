#!/usr/bin/env perl

use strict;
use warnings;

chdir;
my @sorted =
    map { $_->{ORIGINAL} }
    sort { $a->{FOLDED} <=> $b->{FOLDED} }
    map { ORIGINAL => $_, FOLDED => -s $_ },
    glob '*';

print "@sorted\n";
