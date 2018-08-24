use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Horse') or BAIL_OUT();
}

diag( "Testing Horse $Horse::VERSION, Perl $], $^X" );

ok(defined &Horse::sound, 'Horse::sound is defined');

done_testing();
