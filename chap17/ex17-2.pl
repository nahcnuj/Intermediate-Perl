#!/usr/bin/env perl

use strict;
use warnings;

use Oogaboogoo qw(number_to_day_name number_to_month_name);

my ($sec, $min, $hour, $mday, $month, $year, $wday) = localtime;
$year += 1900;

print "Today is ", number_to_day_name($wday), ", ", number_to_month_name($month), " $mday, $year\n";
