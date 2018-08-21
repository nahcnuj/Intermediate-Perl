#!/usr/bin/env perl

use strict;
use warnings;

my %total_bytes;
my %source_sent_bytes;

open my $fh, '<', 'coconet.dat';
while (<>) {
    next if /\A#/;
    my ($source, $destination, $amount) = split;
    $total_bytes{$source}{$destination} += $amount;
}

for my $source (sort keys %total_bytes) {
    print "$source\n";

    my $dest_hash = $total_bytes{$source};
    for my $destination (sort keys %$dest_hash) {
        print " $destination: $dest_hash->{$destination}\n";
    }
}
