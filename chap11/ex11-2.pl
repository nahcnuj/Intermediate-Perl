#!/usr/bin/env perl

use strict;
use warnings;

require Oogaboogoo;

my ($sec, $min, $hour, $mday, $month, $year, $wday) = localtime;
$year += 1900;

print "Today is ", Oogaboogoo::number_to_day_name($wday), ", ", Oogaboogoo::number_to_month_name($month), " $mday, $year\n";
