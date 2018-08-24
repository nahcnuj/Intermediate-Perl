#!/usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 11;

#use Minnow::Diagnostics;

ok( 1, 'ok' );

is(sqrt(0), 0, '√0 = 0');
is(sqrt(1), 1, '√1 = 1');
is(sqrt(49), 7, '√49 = 7');

is(sqrt(0.25), 0.5, '√(0.25) = 0.5');

my $product = sqrt(7) * sqrt(7);
ok($product > 6.999 && $product < 7.001, '(√7)^2 is around 7');

eval { sqrt(-1) };
ok($@, "\$@ is set after sqrt(-1): $@");

eval { sqrt(undef) };
is($@, '', '$@ is not set after sqrt(undef)');

is(sqrt(), 0, 'sqrt() returns 0');

$_ = 100;
is(sqrt, 10, 'sqrt works on $_ by default');

is(sqrt(10**100), 10**50, 'sqrt can handle a googol');
