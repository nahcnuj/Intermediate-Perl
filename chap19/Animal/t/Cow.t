use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Cow') or BAIL_OUT();
}

diag( "Testing Cow $Cow::VERSION, Perl $], $^X" );

ok(defined &Cow::sound, 'Cow::sound is defined');

#is(Cow->sound, 'mooooo', 'Cow goes mooooo');
#ok(Cow->speak, 'Cow goes mooooo');

done_testing();
