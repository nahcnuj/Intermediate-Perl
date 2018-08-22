#!/usr/bin/env perl

use strict;
use warnings;

sub rightmost {
    my ($string, $patterns_ref) = @_;

    my $rightmost = -1;
    my $rightmost_key;
    while (my ($key, $pattern) = each %$patterns_ref) {
        my $position = $string =~ m/$pattern/ ? $-[0] : -1;
        if ($position > $rightmost) {
            $rightmost = $position;
            $rightmost_key = $key;
        }
    }
    
    $rightmost_key;
}

my %patterns = (
    Gilligan => qr/(?:Willie )?Gilligan/,
    'Mary Ann' => qr/Mary Ann/,
    Ginger => qr/Ginger/,
    Professor => qr/(?:The )?Professor/,
    Skipper => qr/Skipper/,
    'A Howell' => qr/Mrs?. Howell/,
);

my $key = rightmost(
    'There is Mrs. Howell, Ginger, and Gilligan',
    \%patterns
);
print "$key\n";
