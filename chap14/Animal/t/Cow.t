use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Cow') or BAIL_OUT();
}

diag( "Testing Cow $Cow::VERSION, Perl $], $^X" );

ok(defined &Cow::sound, 'Cow::sound is defined');

done_testing();
