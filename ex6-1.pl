#!/usr/bin/env perl

use strict;
use warnings;

use Storable qw(store retrieve);
use Data::Dumper;

my $all = '** all machines **';
my $analyzed_log_file = 'analyzed_log.dat';

my %total_bytes;
if (-e $analyzed_log_file) {
    %total_bytes = %{ retrieve $analyzed_log_file };
}

while (<>) {
    next if /\A#/;
    my ($source, $destination, $amount) = split;
    $total_bytes{$source}{$destination} += $amount;
    $total_bytes{$source}{$all} += $amount;
}

store \%total_bytes, $analyzed_log_file;

my @sources = sort {
    $total_bytes{$b}{$all} <=> $total_bytes{$a}{$all}
} keys %total_bytes;

for my $source (@sources) {
    print "$source sent $total_bytes{$source}{$all} bytes in total\n";

    my @destinations = sort {
        $total_bytes{$source}{$b} <=> $total_bytes{$source}{$a}
    } keys %{$total_bytes{$source}};
    for my $destination (@destinations) {
        next if $destination eq $all;
        print "    $source => $destination: $total_bytes{$source}{$destination}\n";
    }
}
