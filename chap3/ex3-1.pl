#!/usr/bin/env perl

use strict;
use warnings;

my @small_files = grep { -s < 1000 } @ARGV;
print map { "    $_\n"} @small_files;
