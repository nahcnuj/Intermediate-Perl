#!/usr/bin/env perl

use strict;
use warnings;

use local::lib;
use Module::CoreList;

my %modules = %{ Module::CoreList::find_version(5.014002) };
for (sort keys %modules) {
    my $date = Module::CoreList::first_release_by_date($_);
    print "$_: $date\n";
}
