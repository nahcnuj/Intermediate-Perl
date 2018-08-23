#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper;
use Storable qw(freeze thaw nstore retrieve dclone);

my @data1 = qw(one won);
my @data2 = qw(two too to);
push @data2, \@data1;
push @data1, \@data2;

my $frozen = freeze [\@data1, \@data2];

my $data = thaw($frozen);

nstore [\@data1, \@data2], 'test.dump';

my $array_ref = retrieve 'test.dump';
print Dumper($array_ref);

my @provisions = qw(hat sunscreen);
my @science_kit = qw(microscope radio);
push @provisions, \@science_kit;

my @packed = @{ dclone \@provisions };   # deep copy

push @packed, 'blue_shirt';
push @{ $packed[2] }, 'batteries';

print Data::Dumper->Dump(
    [ \@provisions ],
    [ qw(*provisions) ]
);
print Data::Dumper->Dump(
    [ \@packed ],
    [ qw(*packed) ]
);

use YAML;
print Dump(\@packed);

use JSON;
my $json_string = to_json( \@packed, { pretty => 1 });

my $hash_ref = from_json($json_string);
print Dump($hash_ref);

my @input_numbers = (1,2,4,8,16,32,64);
my @indices_of_odd_digit_sums = grep {
    my $number = $input_numbers[$_];
    my $sum;
    $sum += $_ for split //, $number;
    $sum % 2;   # odd if true (1)
} 0..$#input_numbers;   # $#array represents index of last element
print "@indices_of_odd_digit_sums\n";

my @x = (2, 0, 1, 8);
my @y = (0, 8, 2, 1);

my @bigger_indices = grep { $_ > $#y or $x[$_] > $y[$_] } 0..$#x;
print "@bigger_indices\n";

my @bigger = map { $_ > $#y or $x[$_] > $y[$_] ? $x[$_] : () } 0..$#x;
print "@bigger\n";

my %provisions = (
	'The Skipper'  => [ qw(blue_shirt hat jacket preserver sunscreen) ], 
	'The Professor'   => [ qw(sunscreen water_bottle slide_rule batteries radio) ],
	'Gilligan' => [ qw(red_shirt hat lucky_socks water_bottle) ],
);

my @who_having_less = grep @{ $provisions{$_} } < 5, keys %provisions;
print "@who_having_less\n";

my @who_having_water_bottle = grep {
    my @items = @{ $provisions{$_} };
    grep $_ eq 'water_bottle', @items;
} keys %provisions;
print "@who_having_water_bottle\n";

my @remapped_list = map { [ $_ => $provisions{$_} ] } keys %provisions;
