use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Mouse') or BAIL_OUT();
}

diag( "Testing Mouse $Mouse::VERSION, Perl $], $^X" );

ok(defined &Mouse::sound, 'Mouse::sound is defined');

is(Mouse->sound, 'squeak', 'Mouse goes squeak');
ok(Mouse->speak, 'Mouse goes squeak');

done_testing();
