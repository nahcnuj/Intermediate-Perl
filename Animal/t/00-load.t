#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 6;

BEGIN {
    for my $class (qw(Animal Cow Horse LivingCreature Mouse Person)) {
        use_ok($class)
            or print "Bail out! $class could not compile!\n";
    }
}

diag( "Testing Animal $Animal::VERSION, Perl $], $^X" );
