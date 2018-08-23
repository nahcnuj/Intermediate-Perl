#!/usr/bin/env perl

use strict;
use warnings;

my $ref_to_noname_array = [ qw(blue_shirt hat) ];

print "$_\n" for @$ref_to_noname_array;
