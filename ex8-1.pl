#!/usr/bin/env perl

use strict;
use warnings;

use IO::Tee;

defined $ARGV[0] && $ARGV[0] =~ /\A(file|scalar|both)\z/i
    or die "Usage: $0 file|scalar|both\n";

my $output_dest = $ARGV[0];
my $scalar_output;

my $output_handle = do {
    if ($output_dest =~ /^f/i) {
        open my $fh, '>', "$0.out" or die "Could not open $0.out: $!";
        $fh;
    } elsif ($output_dest =~ /^s/i) {
        open my $fh, '>', \$scalar_output;
        $fh;
    } else {
        open my $file_handle, '>', "$0.out" or die "Could not open $0.out: $!";
        open my $scalar_handle, '>', \$scalar_output;
        IO::Tee->new($file_handle, $scalar_handle);
    }
};

my ($year, $month, $day, $wday) = (localtime)[5, 4, 3, 6];
$year += 1900;
$wday = qw(Sun Mon Tue Wed Thu Fri Sat)[$wday];

print $output_handle "$year/$month/$day $wday\n";

if ($output_dest =~ /^[sb]/i) {
    print $scalar_output;
}
