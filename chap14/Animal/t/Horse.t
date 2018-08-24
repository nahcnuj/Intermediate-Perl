use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Horse') or BAIL_OUT();
}

diag( "Testing Horse $Horse::VERSION, Perl $], $^X" );

ok(defined &Horse::sound, 'Horse::sound is defined');

is(Horse->sound, 'neigh', 'sound of Horse');
ok(Horse->speak, 'Horse can sound');

done_testing();
