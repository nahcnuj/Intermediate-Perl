#!/usr/bin/env perl

use v5.10;
use strict;
use warnings;

#      index:    0        1       2         3      4        5        6
my @input = qw(Gilligan Skipper Professor Ginger Mary_Ann Thurston Lovery);
my @sorted_position = sort { $input[$a] cmp $input[$b] } 0..$#input;
my @ranks;
@ranks[@sorted_position] = 1..@sorted_position;
print "@ranks\n";
for (0..$#ranks) {
    print "$input[$_] sorts into $ranks[$_]-th position\n";
}

my @wasters;
if (0) {    # too long
    my @pineapples = map {
        [ $_, ask_monkey_about($_) ]
    } @input;
    my @sorted_pineapples = sort {
        $b->[1] <=> $a->[1]
    } @pineapples;
    @wasters = map { $_->[0] } @sorted_pineapples;
} else {
    @wasters =
        map { $_->[0] }
        sort { $b->[1] <=> $a->[1] }
        map [ $_, ask_monkey_about($_) ],
        @input;
}
print join ' ', (map { "$_:" . ask_monkey_about($_) } @wasters), "\n";

sub ask_monkey_about {
    my $key = shift;
    state $pineapples = { map { ($_, int(rand(100) + 1)) } @input };
    $pineapples->{$key};
}
