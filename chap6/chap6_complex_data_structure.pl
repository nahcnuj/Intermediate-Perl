#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper;
$Data::Dumper::Purity = 1;  # there may be data structure with self-reference

my @data1 = qw(one won);
my @data2 = qw(two too to);
push @data2, \@data1;
push @data1, \@data2;
print Data::Dumper->Dump(
    [ \@data1, \@data2 ],
    [ qw(*data1 *data2) ]
);


my %total_bytes;

while (<>) {
    next if /\A#/;
    my ($source, $destination, $amount) = split;
    $total_bytes{$source}{$destination} += $amount;
}

print Dumper(\%total_bytes);

use Data::Dump qw(dump);
dump(\%total_bytes);

use Data::Printer;
p(%total_bytes);
