#!/usr/bin/env perl
use strict;
use warnings;

use RaceHorse;

my $runner = RaceHorse->named('Billy Boy');
$runner->won;
$runner->placed;
$runner->showed;
$runner->lost;
print $runner->name, ' has standings ', $runner->standings, ".\n";
