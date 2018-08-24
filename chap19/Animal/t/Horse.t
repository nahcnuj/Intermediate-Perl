use strict;
use warnings;

use v5.10;
use Test::More;

BEGIN {
    use_ok('Horse') or BAIL_OUT();
}

diag( "Testing Horse $Horse::VERSION, Perl $], $^X" );

ok(defined &Horse::sound, 'Horse::sound is defined');

ok(my $horse = Horse->new(name => "Mr. Ed"), 'create Horse');
$horse->color('grey');
say $horse->name, ' is colored ', $horse->color;

done_testing();
