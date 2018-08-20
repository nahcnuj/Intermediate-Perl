#!/usr/bin/env perl

use strict;
use warnings;

use Business::ISBN;

my $isbn = Business::ISBN->new('9781449393090');
my $group_code = $isbn->group_code;
my $publisher_code = $isbn->publisher_code;
print "Group code is ${group_code}\nPublisher code is ${publisher_code}\n";
