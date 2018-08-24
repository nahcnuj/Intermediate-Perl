#!/usr/bin/env perl
use strict;
use warnings;

use MyDate;

my $date = MyDate->new;
print $date->year, '/', $date->month, '/', $date->day, "\n";

$date->hour; # unknown method
