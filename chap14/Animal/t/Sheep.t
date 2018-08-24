use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Sheep') or BAIL_OUT();
}

diag( "Testing Sheep $Sheep::VERSION, Perl $], $^X" );

ok(defined &Sheep::sound, 'Sheep::sound is defined');

done_testing();
