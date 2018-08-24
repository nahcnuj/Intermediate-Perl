use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Person') or BAIL_OUT();
}

diag( "Testing Person $Person::VERSION, Perl $], $^X" );

ok(defined &Person::sound, 'Person::sound is defined');

is(Person->sound, 'Hmmm~~~', 'Person goes Hamming');
ok(Person->speak, 'Person goes mooooo');
ok(Person->speak('Hello, world!'), 'Person can speak');

done_testing();
