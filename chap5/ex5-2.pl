#!/usr/bin/env perl

use strict;
use warnings;

my %total_bytes;
my %source_sent_bytes;

while (<>) {
    next if /\A#/;
    my ($source, $destination, $amount) = split;
    $total_bytes{$source}{$destination} += $amount;
    $source_sent_bytes{$source} += $amount;
}

my @sources = sort {
    $source_sent_bytes{$b} <=> $source_sent_bytes{$a}
} keys %source_sent_bytes;

for my $source (@sources) {
    print "$source sent $source_sent_bytes{$source} bytes in total\n";

    my @destinations = sort {
        $total_bytes{$source}{$b} <=> $total_bytes{$source}{$a}
    } keys %{$total_bytes{$source}};
    for my $destination (@destinations) {
        print "    $source => $destination: $total_bytes{$source}{$destination}\n";
    }
}
