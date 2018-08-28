use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Mouse') or BAIL_OUT();
}

diag( "Testing Mouse $Mouse::VERSION, Perl $], $^X" );

ok(defined &Mouse::sound, 'Mouse::sound is defined');

done_testing();
